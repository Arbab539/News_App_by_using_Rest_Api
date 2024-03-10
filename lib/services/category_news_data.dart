
import '../models/category_model.dart';

List<CategoryModel> getCategories(){

  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel();

  categoryModel.categoryName = 'Business';
  categoryModel.image = "lib/assets/images/business.jpg";
  category.add(categoryModel);
  categoryModel =  CategoryModel();

  categoryModel.categoryName = 'Entertainment';
  categoryModel.image = "lib/assets/images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel =  CategoryModel();

  categoryModel.categoryName = 'Education';
  categoryModel.image = "lib/assets/images/education.jpg";
  category.add(categoryModel);
  categoryModel =  CategoryModel();

  categoryModel.categoryName = 'Health';
  categoryModel.image = "lib/assets/images/health.jpg";
  category.add(categoryModel);
  categoryModel =  CategoryModel();

  categoryModel.categoryName = 'Sports';
  categoryModel.image = "lib/assets/images/sports.jpg";
  category.add(categoryModel);
  categoryModel =  CategoryModel();

  return category;



}