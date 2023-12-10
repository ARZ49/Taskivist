class Task{
  final String title;
  final String description;
  final String date;
  String isCompleted;

  Task({required this.title,required this.description,required this.date,this.isCompleted = 'False'});
  factory Task.fromMap(Map<String,dynamic> map){
    return Task(
      isCompleted: map['isCompleted'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
    );
  }
  Map<String,dynamic> toMap(){
    return {
   'isCompleted': isCompleted,
      'description':description,
      'title': title,
      'date': date,
    };
  }

}