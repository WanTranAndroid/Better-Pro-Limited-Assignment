enum TransactionStatus {
  created,
  broadcasting, // Persisted locally. Intent to send is locked.
  riskChallenge, // 403 received. Waiting for user input.
  completed, // 200 OK from server.
  failed, // Non-recoverable error (e.g., 400, 500).
  unknown // 504 Timeout. We sent it, but don't know the result.
}
