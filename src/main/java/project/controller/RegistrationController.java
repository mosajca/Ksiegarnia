package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import project.entity.Authority;
import project.entity.User;
import project.services.UserService;

@Controller
public class RegistrationController {

    private final UserService userService;

    @Autowired
    public RegistrationController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping(value = {"/register", "/adminregister"})
    public String registerForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String saveUser(@ModelAttribute("user") User user, Model model) {
        String info = info(user);
        if (!info.isEmpty()) {
            model.addAttribute("info", info);
            return "register";
        }
        user.getAuthorities().add(new Authority(user, "ROLE_USER"));
        userService.saveUser(user);
        return "redirect:/login";
    }

    @PostMapping("/adminregister")
    public String saveAdmin(@ModelAttribute("user") User user, Model model) {
        String info = info(user);
        if (!info.isEmpty()) {
            model.addAttribute("info", info);
            return "register";
        }
        user.getAuthorities().add(new Authority(user, "ROLE_ADMIN"));
        userService.saveUser(user);
        return "redirect:/login";
    }

    private String info(User user) {
        if (userService.getUser(user.getUsername()) != null) {
            return "użytkownik o takiej nazwie istnieje";
        } else if (user.getUsername().isEmpty() || user.getPassword().isEmpty()) {
            return "wypełnij wszystkie pola";
        }
        return "";
    }

}
