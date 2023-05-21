class CancellationToken {
  bool _isCancellationRequested = false;

  bool get isCancellationRequested => _isCancellationRequested;

  void cancel() {
    _isCancellationRequested = true;
  }
}
