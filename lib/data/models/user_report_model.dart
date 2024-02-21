class UserReportModel {
  late String userName;
  late String attendTotal;
  late String attendLec1;
  late String attendLec2;
  late String marathon;
  late String baker;
  late String talta;
  late String sata;
  late String tas3a;
  late String grob;
  late String noom;
  late String ertgalyBaker;
  late String ertgalyNom;
  late String tnawel;
  late String odas;
  late String eatraf;
  late String soom;
  late String oldBible;
  late String newBible;

  UserReportModel(
    this.userName,
    this.attendTotal,
    this.attendLec1,
    this.attendLec2,
    this.marathon,
    this.baker,
    this.talta,
    this.sata,
    this.tas3a,
    this.grob,
    this.noom,
    this.ertgalyBaker,
    this.ertgalyNom,
    this.tnawel,
    this.odas,
    this.eatraf,
    this.soom,
    this.oldBible,
    this.newBible,
  );

  UserReportModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    attendTotal = json['attendTotal'];
    attendLec1 = json['attendLec1'];
    attendLec2 = json['attendLec2'];
    marathon = json['marathon'];
    baker = json['baker'];
    talta = json['talta'];
    sata = json['sata'];
    tas3a = json['tas3a'];
    grob = json['grob'];
    noom = json['noom'];
    ertgalyBaker = json['ertgalyBaker'];
    ertgalyNom = json['ertgalyNom'];
    tnawel = json['tnawel'];
    odas = json['odas'];
    eatraf = json['eatraf'];
    soom = json['soom'];
    oldBible = json['oldBible'];
    newBible = json['newBible'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'attendTotal': attendTotal,
      'attendLec1': attendLec1,
      'attendLec2': attendLec2,
      'marathon': marathon,
      'baker': baker,
      'talta': talta,
      'sata': sata,
      'tas3a': tas3a,
      'grob': grob,
      'noom': noom,
      'ertgalyBaker': ertgalyBaker,
      'ertgalyNom': ertgalyNom,
      'tnawel': tnawel,
      'odas': odas,
      'eatraf': eatraf,
      'soom': soom,
      'oldBible': oldBible,
      'newBible': newBible,
    };
  }
}
