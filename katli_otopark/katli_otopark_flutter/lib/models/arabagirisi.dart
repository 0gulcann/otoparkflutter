class  Task {
  int? id;
  String? plaka;
  String? marka;
  int? isComplated;
  String? startTime;
  String? endTime;

  Task({
    this.id,
    this.plaka,
    this.marka,
    this.isComplated,
    this.startTime,
    this.endTime

  });
  Task.fromJson(Map<String, dynamic> json){

    id=json['id'];
    plaka=json['plaka'];
    marka=json['marka'];
    isComplated=json['isComplated'];
    startTime=json['startTime'];
    endTime=json['endTime'];
  }

  get color => null;

  get title => null;
  
  Map<String, dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id']=this.id;
    data['plaka']=this.plaka;
    data['marka']=this.marka;
    data['isComplated']=this.isComplated;
    data['startTime']=this.startTime;
    data['endTime']=this.endTime;
    return data;
  }
  
}