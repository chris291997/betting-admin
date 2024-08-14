enum ViewModelStatus {
  idle,
  loading,
  success,
  error;

  bool get isIdle => this == ViewModelStatus.idle;

  bool get isLoading => this == ViewModelStatus.loading;

  bool get isSuccess => this == ViewModelStatus.success;

  bool get isError => this == ViewModelStatus.error;
}
