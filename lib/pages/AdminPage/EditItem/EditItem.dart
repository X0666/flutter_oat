import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/theme.dart';

import '../../../GlobalComponent/modal_image_device.dart';
import '../../../providers/product_provider.dart';
import '../../../services/product_service.dart';

class EditItem extends StatefulWidget {
  final title = "Product";
  int imageCount = 0;
  final ProductModel? product;

  EditItem({
    this.product,
    super.key,
  });

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController nameCtrl = TextEditingController(text: '');
  TextEditingController descCtrl = TextEditingController(text: '');
  TextEditingController priceCtrl = TextEditingController(text: '');
  TextEditingController tagsCtrl = TextEditingController(text: '');

  List<File> imageProduct = <File>[];
  List<File> allImages = [];
  int categoriesSelected = 0;
  bool validate = false;

  @override
  void initState() {
    // TODO: implement initState

    print('product edit ${widget.product}');

    nameCtrl.text =
        widget.product != null ? '${widget.product?.name ?? ''}' : '';
    descCtrl.text =
        widget.product != null ? '${widget.product?.description ?? ''}' : '';
    priceCtrl.text =
        widget.product != null ? '${widget.product?.price ?? 0}' : '';
    // tagsCtrl.text =
    //     widget.product != null ? '${widget.product?.tags ?? ''}' : '';

    categoriesSelected =
        widget.product != null ? widget.product!.category!.id! : 0;

    allImages.clear();
    imageProduct.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = new ScrollController();
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    userModel user = authProvider.user;

    createData() async {
      var resp = await ProductService().createProduct(
        user.token!,
        nameCtrl.text,
        descCtrl.text,
        priceCtrl.text,
        categoriesSelected,
        tagsCtrl.text,
        imageProduct,
      );
      await Future.delayed(const Duration(seconds: 2));
      await Provider.of<ProductProvider>(context, listen: false).getProducts();

      productProvider.products =
          await Provider.of<ProductProvider>(context, listen: false).products;

      if (resp == true) {
        Navigator.pop(context);
      } else {
        final snackBar = SnackBar(
          content: const Text('Request Failed'),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    updateData() async {
      var resp = await ProductService().updateProduct(
        user.token!,
        '${widget.product!.id!}',
        nameCtrl.text,
        descCtrl.text,
        priceCtrl.text,
        categoriesSelected,
        tagsCtrl.text,
        imageProduct,
      );
      await Future.delayed(const Duration(seconds: 2));
      await Provider.of<ProductProvider>(context, listen: false).getProducts();

      productProvider.products =
          await Provider.of<ProductProvider>(context, listen: false).products;

      if (resp == true) {
        var nav = Navigator.of(context);
        nav.pop();
        nav.pop();
      } else {
        final snackBar = SnackBar(
          content: const Text('Request Failed'),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    validationCheck() {
      if (nameCtrl.text.isEmpty ||
          descCtrl.text.isEmpty ||
          priceCtrl.text.isEmpty ||
          // tagsCtrl.text.isEmpty ||
          categoriesSelected == 0) {
        setState(() {
          validate = false;
        });
      } else {
        setState(() {
          validate = true;
        });
      }
    }

    postImage(image) {
      setState(() {
        imageProduct.add(image);
        widget.imageCount += 1;
      });

      print('my image ${image}');
    }

    addImage() {
      setState(() {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutQuart,
              child: ModalImageDevice(
                onPressed: (image) => postImage(image),
                ratioX: 0.5,
                ratioY: 0.5,
              ),
            ),
          ),
        );
        validationCheck();
      });
    }

    Widget productPhoto() {
      return Row(
        children: [
          InkWell(
            onTap: () {
              addImage();
            },
            child: Container(
              height: 65,
              width: 65,
              margin: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backgroundColor2,
              ),
              child: Center(
                child: Text(
                  "+ Add",
                  style: TextStyle(
                    fontSize: 40,
                    color: backgroundColor1,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 65,
              child: ScrollConfiguration(
                behavior: AppScrollBehavior(),
                child: GridView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const PageScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 2.0,
                    crossAxisCount: 1,
                    childAspectRatio: 1,
                  ),
                  children: List.generate(widget.imageCount, (index) {
                    return Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundColor2,
                      ),
                      child: Image.file(imageProduct[index]),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget body() {
      return Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 15),
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Expanded(
                child: TextFormField(
                  controller: nameCtrl,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Name',
                    hintStyle: SubtitleTextStyle,
                  ),
                  onChanged: (value) => validationCheck(),
                ),
              )),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Expanded(
                child: TextFormField(
                  controller: descCtrl,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Description',
                    hintStyle: SubtitleTextStyle,
                  ),
                  onChanged: (value) => validationCheck(),
                ),
              )),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Expanded(
                child: TextFormField(
                  controller: priceCtrl,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Price',
                    hintStyle: SubtitleTextStyle,
                  ),
                  onChanged: (value) => validationCheck(),
                ),
              )),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select Categories"),
                GridView.count(
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: (1 / .4),
                  children: productProvider.categories.map(
                    (val) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            categoriesSelected = val.id!;
                            validationCheck();
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 2,
                                color: categoriesSelected == val.id
                                    ? backgroundColor4
                                    : backgroundColor5),
                            color: backgroundColor5,
                          ),
                          height: 40,
                          width: 40,
                          child: Center(
                            child: Text('${val.name}'),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
            // Container(
            //   height: 50,
            //   margin: EdgeInsets.symmetric(vertical: 10),
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   decoration: BoxDecoration(
            //     color: backgroundColor2,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Center(
            //       child: Expanded(
            //     child: TextFormField(
            //       controller: nameCtrl,
            //       decoration: InputDecoration.collapsed(
            //         hintText: 'Categories',
            //         hintStyle: SubtitleTextStyle,
            //       ),
            //     ),
            //   )),
            // ),
            // Container(
            //   height: 50,
            //   margin: EdgeInsets.symmetric(vertical: 10),
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   decoration: BoxDecoration(
            //     color: backgroundColor2,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Center(
            //       child: Expanded(
            //     child: TextFormField(
            //       controller: tagsCtrl,
            //       decoration: InputDecoration.collapsed(
            //         hintText: 'Tags',
            //         hintStyle: SubtitleTextStyle,
            //       ),
            //       onChanged: (value) => validationCheck(),
            //     ),
            //   )),
            // ),
          ],
        ),
      );
    }

    Widget submitButton() {
      return InkWell(
        onTap: () {
          validate != false
              ? widget.product != null
                  ? updateData()
                  : createData()
              : null;
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          height: 44,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: validate == false ? backgroundColor5 : backgroundColor3,
          ),
          child: Center(
            child: Text(
              "Submit",
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productPhoto(),
              body(),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class ImageHelper {
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 50,
    // bool multiple = false,
  }) async {
    final file = await _imagePicker.pickImage(
      source: source,
      imageQuality: imageQuality,
    );

    return file;
  }

  Future<CroppedFile?> crop({
    required XFile file,
    double ratioX = 1,
    double rationY = 1,
  }) async =>
      await _imageCropper.cropImage(
          sourcePath: file.path,
          compressQuality: Platform.isAndroid ? 70 : 20,
          cropStyle: CropStyle.rectangle,
          aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: rationY));
}
