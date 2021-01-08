export class Status {
  
  /**
   * @property {number}
   */
  static SUCCESS: number = 200;

  /**
   * @property {number}
   */
  static BAD_REQUEST: number = 400;

  /**
   * @property {number}
   */
  static UNAUTHORIZED: number = 401;

  /**
   * @property {number}
   */
  static FORBIDDEN: number = 403;

  /**
   * @property {number}
   */
  static NOT_FOUND: number =  404;

}

export class AppResponse {

  /**
   * @property {number}
   */
  public code: number;

  /**
   * @property {object}
   */
  public data: object;

  /**
   * @property {string}
   */
  public message: string

  /**
   * @property {boolean}
   */
  public status: boolean;

  /**
   * class private constructor
   * 
   * @param code {number}
   * @param status {boolean}
   * @param message {string}
   * @param data {object}
   */
  private constructor(code: number, status: boolean, message: string, data: object) {
    this.code = code;
    this.data = data;
    this.message = message;
    this.status = status;
  }

  /**
   * factory method for creating response 
   * object for unauthorized response
   * 
   * @param message {string}
   * @param data {object}
   * @returns {AppResponse}
   */
  public static unauthorized(message: string, data: object = {}): AppResponse {
    return new AppResponse(Status.UNAUTHORIZED, false, message, data);
  }

  /**
   * factory method for creating response
   * object for bad requests
   * 
   * @param message {string}
   * @param data {object}
   * @returns {AppResponse}
   */
  public static badRequest(message: string, data: object = {}): AppResponse {
    return new AppResponse(Status.BAD_REQUEST, false, message, data);
  }

  /**
   * factory method for creating response
   * object for successful requests
   * 
   * @param message {string}
   * @param data {object}
   * @returns {AppResponse}
   */
  public static success(message: string, data: object = {}): AppResponse {
    return new AppResponse(Status.SUCCESS, true, message, data);
  }

  /**
   * factory method for creating response
   * object for forbidden requests
   * 
   * @param message {string}
   * @param data {object}
   * @returns {AppResponse}
   */
  public static forbidden(message: string, data: object = {}): AppResponse {
    return new AppResponse(Status.FORBIDDEN, false, message, data);
  }

  /**
   * factory method for creating response 
   * object for not found
   * 
   * @param message {string}
   * @param data {object}
   * @returns {AppResponse}
   */
  public static notFound(message: string, data: object = {}): AppResponse {
    return new AppResponse(Status.NOT_FOUND, false, message, data);
  }

  /**
   * returns a json of the instance
   * properties
   * 
   * @param _instance {AppResponse}
   * @returns {object}
   */
  public static toJson(_instance: AppResponse): object {
    return {code: _instance.code, message: _instance.message, status: _instance.status, data: _instance.data};
  }
}