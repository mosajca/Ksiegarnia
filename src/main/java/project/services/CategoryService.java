package project.services;

import java.util.List;

import project.entity.Category;

public interface CategoryService {

    List<Category> getCategories();

    void saveCategory(Category category);

    Category getCategory(int categoryId);

    void deleteCategory(int categoryId);

}
