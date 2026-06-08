class InfoItemModel {
  final String title;
  final String description;

 const InfoItemModel({required this.title,required this.description});
 static final List<InfoItemModel>infoList=const [
   InfoItemModel(title: "Supported Formats", description: "JPG, PNG and other medical imaging formats"),
   InfoItemModel(title: "Privacy", description: "All uploads are processed securely  and stored with encryption"),
   InfoItemModel(title: "AI Analysis", description: "Advanced algorithms find similar cases from medical database"),


  ];


}