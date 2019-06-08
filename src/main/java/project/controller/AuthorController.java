package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import project.entity.Author;
import project.services.AuthorService;

@Controller
@RequestMapping("/authors")
public class AuthorController {

    private final AuthorService authorService;

    @Autowired
    public AuthorController(AuthorService authorService) {
        this.authorService = authorService;
    }

    @GetMapping("/list")
    public String listAuthors(Model model) {
        model.addAttribute("authors", authorService.getAuthors());
        return "authorslist";
    }

    @GetMapping("/formadd")
    public String addForm(Model model) {
        model.addAttribute("author", new Author());
        return "addauthorform";
    }

    @PostMapping("/saveAuthor")
    public String saveAuthor(@ModelAttribute("author") Author author) {
        authorService.saveAuthor(author);
        return "redirect:/authors/list";
    }

    @GetMapping("updateAuthorForm")
    public String updateAuthorForm(@RequestParam("authorId") int authorId, Model model) {
        model.addAttribute("author", authorService.getAuthor(authorId));
        return "addauthorform";
    }

    @GetMapping("deleteAuthorForm")
    public String deleteAuthorForm() {
        return "delete";
    }

    @PostMapping("deleteAuthorForm")
    public String deleteAuthor(@RequestParam("authorId") int authorId) {
        authorService.deleteAuthor(authorId);
        return "redirect:/authors/list";
    }

}
