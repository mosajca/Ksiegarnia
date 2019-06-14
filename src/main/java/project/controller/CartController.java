package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import project.component.Cart;
import project.services.BookService;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final Cart cart;
    private final BookService bookService;

    @Autowired
    public CartController(Cart cart, BookService bookService) {
        this.cart = cart;
        this.bookService = bookService;
    }

    @GetMapping
    public String cart(Model model) {
        model.addAttribute("books", bookService.getBooks(cart.getBookIds()));
        return "cart";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam(name = "bookId") int id) {
        cart.addBookId(id);
        return "redirect:/cart";
    }

    @PostMapping("/delete")
    public String deleteFromCart(@RequestParam(name = "bookId") int id) {
        cart.deleteBookId(id);
        return "redirect:/cart";
    }

}
