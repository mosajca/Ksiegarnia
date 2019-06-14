package project.component;

import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.SessionScope;

@Component
@SessionScope
public class Cart {

    private Set<Integer> bookIds = new HashSet<>();

    public void addBookId(Integer id) {
        bookIds.add(id);
    }

    public void deleteBookId(Integer id) {
        bookIds.remove(id);
    }

    public Set<Integer> getBookIds() {
        return bookIds;
    }

}
