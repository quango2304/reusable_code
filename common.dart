//map async
Future<List<String?>?> selectImages() async {
  try {
    isLoading.value = true;
    final localPhotoModels = await LocalFileService.selectImages();
    var remoteImagesModel = await Future.wait<PhotoModel>([
      for (var index = 0; index < localPhotoModels.length; index++)
        repository.uploadLocalImage(localPhotoModel: localPhotoModels[index])
    ]);
    isLoading.value = false;
    return remoteImagesModel.map((e) => e.cdnUrl).toList();
  } catch (e, s) {
    print('$e $s');
    isLoading.value = false;
    error.value = e.toString();
    return null;
  }
}
Matrix4.identity()..scale(1.0, 0.05)

//remove some lib from yalm file
sed -i.bak '/sqlite3_flutter_libs:/d' pubspec.yaml
