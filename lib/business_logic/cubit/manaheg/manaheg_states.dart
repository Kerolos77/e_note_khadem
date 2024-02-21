abstract class ManahegStates {}

class InitialManahegState extends ManahegStates {}

class ChangeManahegState extends ManahegStates {}

class ChangeShowContainerManahegState extends ManahegStates {}

class CreateBarcodeLoadingManahegState extends ManahegStates {}

class CreateBarcodeSuccessManahegState extends ManahegStates {}

class CreateBarcodeErrorManahegState extends ManahegStates {
  late String error;

  CreateBarcodeErrorManahegState(this.error);
}

class DeleteBarcodeLoadingManahegState extends ManahegStates {}

class DeleteBarcodeSuccessManahegState extends ManahegStates {}

class DeleteBarcodeErrorManahegState extends ManahegStates {
  late String error;

  DeleteBarcodeErrorManahegState(this.error);
}

class LogOutSuccessManahegState extends ManahegStates {}

class GetManahegSuccessManahegState extends ManahegStates {}

class GetManahegLoadingManahegState extends ManahegStates {}

class UploadFileLoadingManahegState extends ManahegStates {}

class UploadFileSuccessManahegState extends ManahegStates {
  late String name;

  UploadFileSuccessManahegState(this.name);
}

class UploadFileErrorManahegState extends ManahegStates {
  late String error;

  UploadFileErrorManahegState(this.error);
}

class DeleteFileLoadingManahegState extends ManahegStates {}

class DeleteFileSuccessManahegState extends ManahegStates {
  late String name;

  DeleteFileSuccessManahegState(this.name);
}

class DeleteFileErrorManahegState extends ManahegStates {
  late String error;

  DeleteFileErrorManahegState(this.error);
}
