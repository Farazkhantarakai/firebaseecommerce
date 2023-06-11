import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerce/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FirestoreMethods extends GetxController {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final userCollection = FirebaseFirestore.instance;

  final uId = FirebaseAuth.instance.currentUser!.uid;
  // final _firebaseAuth = FirebaseFirestore.instance;
  RxList<Product> data = <Product>[].obs;
  RxList<Product> _searchedProduct = <Product>[].obs;
  RxList<Product> _favouriteProduct = <Product>[].obs;

  //  RxBool _isLoaded = false.obs;
  final RxBool _isFirstLoaded = true.obs;

  // ignore: invalid_use_of_protected_member
  List<Product> get getAllData => data.value;
  // ignore: invalid_use_of_protected_member
  List<Product> get getFavouriteItem => _favouriteProduct.value
      .where((prod) => prod.isFavourite == true)
      .toList();
  bool get getFirstLoaded => _isFirstLoaded.value;

  Future<List<Product>> searchItems(String searchItem) async {
    final documentSnapshot = await _firebaseFirestore
        .collection('meals')
        .where('title', isEqualTo: searchItem)
        .get();

    _searchedProduct.value = documentSnapshot.docs.map<Product>((doc) {
      final Map<String, dynamic> data = doc.data();

      return Product.fromMap(data);
    }).toList();

    // ignore: invalid_use_of_protected_member
    return _searchedProduct.value;
  }

  getProfilePic() async {
    DocumentSnapshot data =
        await userCollection.collection('user').doc(uId).get();
    debugPrint(data.data().toString());
    return data;
  }

  getCategoriesOfItem({required category}) async {
    final documentSnapshot = await _firebaseFirestore.collection('meals').get();
    data.value = documentSnapshot.docs.map<Product>((doc) {
      final Map<String, dynamic> data = doc.data();
      return Product.fromMap(data);
    }).toList();

    data.value.forEach((element) {
      debugPrint(element.title);
    });

    data.value =
        // ignore: invalid_use_of_protected_member
        data.value.where((product) => product.category == category).toList();
    // ignore: invalid_use_of_protected_member
    debugPrint(data.value.toString());
    _isFirstLoaded.value = true;
  }

  addItemsToFavourite(Product pro) {
    // ignore: invalid_use_of_protected_member
    _favouriteProduct.value.add(pro);
    debugPrint(' add items to favourite  ${_favouriteProduct.value}');
    update();
  }

  removeItemsFromFavourite(Product pro) {
    _favouriteProduct.value.remove(pro);
    debugPrint('remove item to favourite ${_favouriteProduct.value}');
    update();
  }

  uploadProfile(String imageUrl) async {
    await userCollection
        .collection('user')
        .doc(uId)
        .update({"imageUrl": imageUrl});
  }

  updateProfileInfo(String name, String email, String phoneNumber) async {
    await userCollection
        .collection('user')
        .doc(uId)
        .update({"name": name, "email": email, "phoneNumber": phoneNumber});
  }

  Future<String> uploadImage(Uint8List image) async {
    if (kDebugMode) {
      print('uploading image in flutter');
    }
    // create a firebasestorage reference
    try {
      final storageReference =
          FirebaseStorage.instance.ref().child('image/$uId.png');
      // upload the file to firebase storage
      final uploadTask = storageReference.putData(image);
      //wait for the uplaod to complete
      final taskSnapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      rethrow;
    }
  }

  void changeProductFavourite({required int id, required isFavourite}) async {
    try {
      final collectionReference = _firebaseFirestore.collection('meals');
      final querySnapshot =
          await collectionReference.where('id', isEqualTo: id).get();

      final documentSnapshot = querySnapshot.docs.first;
      final reference = documentSnapshot.reference;
      reference.update({'isFavourite': isFavourite});
    } on FirebaseException catch (err) {
      debugPrint(err.toString());
    }
  }

  getFavouriteItems() async {
    final documents = await _firebaseFirestore.collection('meals').get();

    List<Product> data = documents.docs.map<Product>((doc) {
      final data = doc.data();

      return Product.fromMap(data);
    }).toList();
    _favouriteProduct.value = [];

    _favouriteProduct.value =
        data.where((product) => product.isFavourite == true).toList();
  }

  Future<List<Product>> getData() async {
    try {
      // debugPrint('is in the first');
      final documentSnapshot =
          await _firebaseFirestore.collection('meals').get();
      data.value = documentSnapshot.docs.map<Product>((doc) {
        final Map<String, dynamic> data = doc.data();
        return Product.fromMap(data);
      }).toList();

      data.value =
          // ignore: invalid_use_of_protected_member
          data.value.where((product) => product.category == 'pizza').toList();

      // isLoaded.value = true;
      _isFirstLoaded.value = false;

      // debugPrint(isLoaded.toString());
      debugPrint(data.toString());
    } on FirebaseException catch (err) {
      debugPrint(err.toString());
    }
    // ignore: invalid_use_of_protected_member
    return data.value;
  }
}
