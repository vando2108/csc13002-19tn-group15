class Message {
  final String message;
  final String senderid;
  final String reciverid;
  final DateTime time;

  Message(this.message, this.senderid, this.reciverid, this.time);

  Message.fromJson(Map<String, dynamic> json)
      : message = json['content'],
        senderid = json['sender'],
        reciverid = json['receiver'],
        time = DateTime.parse(json['time']);
}
