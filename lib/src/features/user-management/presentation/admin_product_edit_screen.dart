import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/action_text_button.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/common_widgets/async_value_widget.dart';
import 'package:home_front_pk/src/common_widgets/custom_image.dart';
import 'package:home_front_pk/src/common_widgets/custom_text_button.dart';
import 'package:home_front_pk/src/common_widgets/error_message_widget.dart';
import 'package:home_front_pk/src/common_widgets/responsive_center.dart';
import 'package:home_front_pk/src/common_widgets/responsive_two_column_layout.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/constructor_repository.dart';
// import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/fake_constructor_repo.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';
import 'package:home_front_pk/src/features/user-management/data/template_products_providers.dart';
import 'package:home_front_pk/src/features/user-management/presentation/product_validator.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';

/// Widget screen for updating existing products (edit mode).
/// Products are first created inside [AdminProductUploadScreen].
class AdminProductEditScreen extends ConsumerWidget {
  const AdminProductEditScreen({super.key, required this.constructorID});
  final ConstructorID constructorID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final constructorValue = ref.watch(constructorProvider(constructorID));
    return AsyncValueWidget<ConstructorIslamabad?>(
      value: constructorValue,
      data: (product) => product != null
          ? AdminProductEditScreenContents(constructor: product)
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit Product'.hardcoded),
              ),
              body: Center(
                child: ErrorMessageWidget('Product not found'.hardcoded),
              ),
            ),
    );
  }
}

/// Widget containing most of the UI for editing a product
class AdminProductEditScreenContents extends ConsumerStatefulWidget {
  const AdminProductEditScreenContents({super.key, required this.constructor});
  final ConstructorIslamabad constructor;

  @override
  ConsumerState<AdminProductEditScreenContents> createState() =>
      _AdminProductScreenContentsState();
}

class _AdminProductScreenContentsState
    extends ConsumerState<AdminProductEditScreenContents> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _nameController = TextEditingController();

  ConstructorIslamabad get constructor => widget.constructor;

  @override
  void initState() {
    super.initState();
    // Initialize text fields with product data
    _titleController.text = constructor.title;
    _descriptionController.text = constructor.detail;
    _locationController.text = constructor.location;
    _nameController.text = constructor.name;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadFromTemplate() async {
    final template =
        await ref.read(templateProductProvider(constructor.id).future);
    if (template != null) {
      _titleController.text = template.title;
      _descriptionController.text = template.detail;
      _locationController.text = template.location;
      _nameController.text = template.name;
      _formKey.currentState!.validate();
    }
  }

  Future<void> _delete() async {
    await showAlertDialog(
      context: context,
      title: 'Not implemented'.hardcoded,
    );
    // TODO: Uncomment
    // final delete = await showAlertDialog(
    //   context: context,
    //   title: 'Are you sure?'.hardcoded,
    //   cancelActionText: 'Cancel'.hardcoded,
    //   defaultActionText: 'Delete'.hardcoded,
    // );
    // if (delete == true) {
    //   ref
    //       .read(adminProductEditControllerProvider.notifier)
    //       .deleteProduct(product);
    // }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      await showAlertDialog(
        context: context,
        title: 'Not implemented'.hardcoded,
      );
      // TODO: Uncomment
      // final scaffoldMessenger = ScaffoldMessenger.of(context);
      // await ref.read(adminProductEditControllerProvider.notifier).updateProduct(
      //       product: product,
      //       title: _titleController.text,
      //       description: _descriptionController.text,
      //       price: _priceController.text,
      //       availableQuantity: _availableQuantityController.text,
      //     );
      // // Inform the user that the product has been updated
      // scaffoldMessenger.showSnackBar(
      //   SnackBar(
      //     content: Text(
      //       'Product updated'.hardcoded,
      //     ),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Uncomment
    // ref.listen<AsyncValue>(
    //   adminProductEditControllerProvider,
    //   (_, state) => state.showAlertDialogOnError(context),
    // );
    // final state = ref.watch(adminProductEditControllerProvider);
    // final isLoading = state.isLoading;
    const isLoading = false;
    const autovalidateMode = AutovalidateMode.disabled;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'.hardcoded),
        actions: [
          ActionTextButton(
            text: 'Save'.hardcoded,
            onPressed: isLoading ? null : _submit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveCenter(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Form(
            key: _formKey,
            child: ResponsiveTwoColumnLayout(
              startContent: Card(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: CustomImage(imageUrl: constructor.imageUrl),
                ),
              ),
              spacing: Sizes.p16,
              endContent: Card(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          label: Text('Title'.hardcoded),
                        ),
                        autovalidateMode: autovalidateMode,
                        validator:
                            ref.read(productValidatorProvider).titleValidator,
                      ),
                      gapH8,
                      TextFormField(
                        controller: _descriptionController,
                        enabled: !isLoading,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          label: Text('Description'.hardcoded),
                        ),
                        autovalidateMode: autovalidateMode,
                        validator: ref
                            .read(productValidatorProvider)
                            .descriptionValidator,
                      ),
                      gapH8,
                      TextFormField(
                        controller: _locationController,
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          label: Text('Location'.hardcoded),
                        ),
                      ),
                      gapH8,
                      TextFormField(
                        controller: _nameController,
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          label: Text('name'.hardcoded),
                        ),
                        autovalidateMode: autovalidateMode,
                        validator: ref
                            .read(productValidatorProvider)
                            .availableQuantityValidator,
                      ),
                      gapH16,
                      const Divider(),
                      gapH8,
                      EditProductOptions(
                        onLoadFromTemplate:
                            isLoading ? null : _loadFromTemplate,
                        onDelete: isLoading ? null : _delete,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Responsive widget with options to preload product data and delete a product
class EditProductOptions extends StatelessWidget {
  const EditProductOptions(
      {super.key, required this.onLoadFromTemplate, required this.onDelete});
  final VoidCallback? onLoadFromTemplate;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ResponsiveTwoColumnLayout(
      rowMainAxisAlignment: MainAxisAlignment.center,
      startContent: CustomTextButton(
        text: 'Load from Template'.hardcoded,
        style: Theme.of(context).textTheme.titleSmall,
        onPressed: onLoadFromTemplate,
      ),
      endContent: CustomTextButton(
        text: 'Delete Product'.hardcoded,
        style:
            Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.red),
        onPressed: onDelete,
      ),
      spacing: Sizes.p8,
    );
  }
}
