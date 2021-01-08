<?php

namespace app\services\file;

class File {
  
  /**
   * @property string $encodedFile
   */
  private $encodedFile;

  /**
   * @property string $decodedFile
   */
  private $decodedFile;

  /**
   * @var array SUPPORTED_EXTENSIONS
   */
  const SUPPORTED_EXTENSIONS = ['jpg', 'jpeg', 'png'];

  /**
   * @var string UPLOAD RELATIVE PATH
   */
  const UPLOAD_PATH = '../../uploads/';

  /**
   * @var string profile image path
   */
  public const PROFILE_PATH = 'profile/';

  /**
   * @var string service path
   */
  public const SERVICE_PATH = 'service/';

   /**
   * @var string service category path
   */
  public const SERVICE_CATEGORY_PATH = 'service_category/';

  /**
   * @var int maximum allowed file size in bytes
   */
  public const FILE_MAX_SIZE = 5000000;

  function __construct($encodedFile) {
    $this->encodedFile = $encodedFile;
    $this->decodedFile = $this->decodeBase64String();
  }

  /**
   * decodeBase64String decodes the base 64 encoded image string
   * @param void
   * @return string|false
   */
  private function decodeBase64String() {
    $extractImgString = explode(',', $this->encodedFile);
    $extracted = count($extractImgString) == 1 ? $extractImgString[0] : $extractImgString[1];
    return base64_decode($extracted);
  }

  /**
   * serverHost returns the base url by checking what protocol the server
   * uses and the server host before appending the directory name used for uploads
   * @param void
   * @return string
   */
  public static function serverHost(): string {
    $protocol = isset($_SERVER['HTTPS']) ? "https://" : "http://";
    return ($protocol . $_SERVER['HTTP_HOST']. "/fynryt/uploads/");
  }

  /**
   * mimeType returns file mime type from the file base64 decoded string
   * @param string
   * @return string
   */
  public function mimeType(): string {
    $finfoOpen = finfo_open();
    $fileType = finfo_buffer($finfoOpen, $this->decodedFile, FILEINFO_MIME_TYPE);
    return $fileType;
  }

  /**
   * getFileExt returns the file extension from the mime type
   * @param void
   * @return string
   */
  public function getFileExt(): string {
    $fileExt = explode('/', $this->mimeType())[1];
    return $fileExt;
  }

  /**
   * isExtensionValid validates if file extension satisfies condition in the method
   * @param void
   * @return boolean
   */
  public function isExtensionValid(): bool {
    $fileExt = $this->getFileExt();
    return in_array($fileExt, self::SUPPORTED_EXTENSIONS);
  }

  /**
   * generateFileName takes an Id in the parameter to append to the
   * generated name for the image file using unique id
   * @param string $id
   * @return string
   */
  public function generateFileName(): string {
    $newImgName = uniqid(rand(0, 1000), true) . ".".$this->getFileExt();
    return $newImgName;
  }

  /**
   * gets image size from resource
   * @param void
   * @return void
   */
  public function getImageSize() {
    return getimagesizefromstring($this->decodedFile);
  }

  /**
   * upLoadFile uploads file to the server and generates a url for the file so the file can be found on the 
   * @param string $type profile|service
   * @param string $id
   * @return array $status & $filePath
   */
  public function upLoadFile(string $path): array {
    $fileName = $this->generateFileName();
    if (!$this->isExtensionValid()) return ['status' => false, 'message' => 'file is not supported'];
    $uploadDir = self::UPLOAD_PATH . $path . $fileName;
    $filePathByUrl = self::serverHost() . $path . $fileName;
    if (file_put_contents($uploadDir, $this->decodedFile)) {
      return ['status' => true, 'filePath' => $filePathByUrl];
    }
    return ['status' => false, 'message' => 'Upload error'];
  }

}