class TransectionDetails {
  final int? id;
  final int? transectionId;
  final String? userName;
  final String? senderName;
  final double? transectionAmount;

  TransectionDetails({
    this.id,
    this.transectionId,
    this.userName,
    this.transectionAmount,
    this.senderName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transectionId': transectionId,
      'userName': userName,
      'senderName': senderName,
      'transectionAmount': transectionAmount,
    };
  }
}
