class MatchInsight {
  final String content;
  final bool isLoading;
  final String? error;

  MatchInsight({
    required this.content,
    this.isLoading = false,
    this.error,
  });

  factory MatchInsight.loading() {
    return MatchInsight(
      content: '',
      isLoading: true,
    );
  }

  factory MatchInsight.error(String errorMessage) {
    return MatchInsight(
      content: '',
      error: errorMessage,
    );
  }

  factory MatchInsight.empty() {
    return MatchInsight(
      content: '',
    );
  }

  bool get isEmpty => content.isEmpty && !isLoading && error == null;
  bool get hasError => error != null;
}
