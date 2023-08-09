class Task{
  final String title;
  final String description;
  final String date;

  Task({required this.title,required this.description,required this.date});
  factory Task.fromMap(Map<String,dynamic> map){
    return Task(
      
      title: map['title'],
      description: map['description'],
      date: map['date'],
    );
  }
  Map<String,dynamic> toMap(){
    return {
   
      'description':description,
      'title': title,
      'date': date,
    };
  }

}