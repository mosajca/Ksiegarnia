package project.controller;

import java.util.HashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import project.component.Cart;
import project.entity.Order;
import project.entity.User;
import project.services.BookService;
import project.services.OrderService;

@Controller
@RequestMapping("/orders")
public class OrderController {

    private final Cart cart;
    private final BookService bookService;
    private final OrderService orderService;

    @Autowired
    public OrderController(Cart cart, BookService bookService, OrderService orderService) {
        this.cart = cart;
        this.bookService = bookService;
        this.orderService = orderService;
    }

    @GetMapping
    public String listOrders(Model model, Authentication authentication) {
        if (isAdmin(authentication)) {
            model.addAttribute("orders", orderService.getOrders());
        } else {
            model.addAttribute("orders", orderService.getOrders(authentication.getName()));
        }
        return "orders";
    }

    @PostMapping
    public String saveOrder(Authentication authentication) {
        Order order = new Order();
        order.setStatus("złożone");
        order.setUser(new User(authentication.getName()));
        order.setBooks(new HashSet<>(bookService.getBooks(cart.getBookIds())));
        orderService.saveOrder(order);
        return "redirect:/orders";
    }

    @PostMapping("complete")
    public String completeOrder(@RequestParam(name = "orderId") int id) {
        orderService.completeOrder(id);
        return "redirect:/orders";
    }

    private boolean isAdmin(Authentication authentication) {
        return authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .anyMatch("ROLE_ADMIN"::equals);
    }

}
