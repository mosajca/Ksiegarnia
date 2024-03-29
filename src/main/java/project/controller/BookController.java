package project.controller;

import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import project.dto.BookSearch;
import project.entity.Book;
import project.services.AuthorService;
import project.services.BookService;
import project.services.CategoryService;
import project.util.PDF;

@Controller
@RequestMapping("/books")
public class BookController {

    private final AuthorService authorService;
    private final BookService bookService;
    private final CategoryService categoryService;

    @Autowired
    public BookController(AuthorService authorService, BookService bookService, CategoryService categoryService) {
        this.authorService = authorService;
        this.bookService = bookService;
        this.categoryService = categoryService;
    }

    @GetMapping("/list")
    public String listBooks(Model model, @RequestParam(name = "sort", defaultValue = "") String sort) {
        model.addAttribute("books", bookService.getBooks(sort));
        model.addAttribute("search", new BookSearch());
        return "bookslist";
    }

    @GetMapping(value = "/list", params = {"title", "publisher", "price", "category", "author"})
    public String listBooksSearch(Model model, @ModelAttribute("search") BookSearch search,
                                  @RequestParam(name = "sort", defaultValue = "") String sort) {
        model.addAttribute("books", bookService.getBooks(search, sort));
        model.addAttribute("search", search);
        return "bookslist";
    }

    @GetMapping("/formadd")
    public String addForm(Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("authors", authorService.getAuthors());
        model.addAttribute("categories", categoryService.getCategories());
        return "addbookform";
    }

    @PostMapping("/saveBook")
    public String saveBook(@ModelAttribute("book") Book book) {
        bookService.saveBook(book);
        return "redirect:/books/list";
    }

    @GetMapping("/updateBookForm")
    public String updateBookForm(@RequestParam("bookId") int bookId, Model model) {
        model.addAttribute("book", bookService.getBook(bookId));
        model.addAttribute("authors", authorService.getAuthors());
        model.addAttribute("categories", categoryService.getCategories());
        return "addbookform";
    }

    @GetMapping("/deleteBookForm")
    public String deleteBookForm() {
        return "delete";
    }

    @PostMapping("/deleteBookForm")
    public String deleteBook(@RequestParam("bookId") int bookId) {
        bookService.deleteBook(bookId);
        return "redirect:/books/list";
    }

    @GetMapping(value = "/pdf", produces = MediaType.APPLICATION_PDF_VALUE)
    @ResponseBody
    public byte[] getPDF(HttpServletResponse response, @RequestParam(name = "sort", defaultValue = "") String sort) {
        response.addHeader("Content-Disposition", "inline; filename=\"books.pdf\"");
        return new PDF("Książki", bookService.getBooks(sort).stream().map(Book::toText).collect(Collectors.toList()))
                .generate();
    }

    @GetMapping(value = "/pdf", params = {"title", "publisher", "price", "category", "author"},
            produces = MediaType.APPLICATION_PDF_VALUE)
    @ResponseBody
    public byte[] getPDFSearch(HttpServletResponse response, @ModelAttribute("search") BookSearch search,
                               @RequestParam(name = "sort", defaultValue = "") String sort) {
        response.addHeader("Content-Disposition", "inline; filename=\"books.pdf\"");
        return new PDF("Książki", bookService.getBooks(search, sort)
                .stream().map(Book::toText).collect(Collectors.toList()))
                .generate();
    }

}
