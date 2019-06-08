package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import project.entity.Category;
import project.services.CategoryService;

@Controller
@RequestMapping("/categories")
public class CategoryController {

    private final CategoryService categoryService;

    @Autowired
    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping("/list")
    public String listCategories(Model model) {
        model.addAttribute("categories", categoryService.getCategories());
        return "categorieslist";
    }

    @GetMapping("/formadd")
    public String addForm(Model model) {
        model.addAttribute("category", new Category());
        return "addcategoryform";
    }

    @PostMapping("/saveCategory")
    public String saveCategory(@ModelAttribute("category") Category category) {
        categoryService.saveCategory(category);
        return "redirect:/categories/list";
    }

    @GetMapping("updateCategoryForm")
    public String updateCategoryForm(@RequestParam("categoryId") int categoryId, Model model) {
        model.addAttribute("category", categoryService.getCategory(categoryId));
        return "addcategoryform";
    }

    @GetMapping("deleteCategoryForm")
    public String deleteCategoryForm() {
        return "delete";
    }

    @PostMapping("deleteCategoryForm")
    public String deleteCategory(@RequestParam("categoryId") int categoryId) {
        categoryService.deleteCategory(categoryId);
        return "redirect:/categories/list";
    }

}
