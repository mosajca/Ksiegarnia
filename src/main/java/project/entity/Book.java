package project.entity;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "ksiazki")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;
    @Column(name = "nazwa")
    private String name;
    @Column(name = "wydawnictwo")
    private String publisher;
    @Column(name = "cena")
    private float price;

    @ManyToMany
    @JoinTable(
            name = "autorzy_to_ksiazki",
            joinColumns = @JoinColumn(name = "ksiazka_id"),
            inverseJoinColumns = @JoinColumn(name = "autor_id")
    )
    private Set<Author> authors;

    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinColumn(name = "kategoria_id")
    private Category category;

    @ManyToMany(mappedBy = "books")
    private Set<Order> orders;

    public Book() {
    }

    public Book(int id) {
        this.id = id;
    }

    public Book(String name, String publisher, float price) {
        this.name = name;
        this.publisher = publisher;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public Set<Author> getAuthors() {
        return authors;
    }

    public void setAuthors(Set<Author> authors) {
        this.authors = authors;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Set<Order> getOrders() {
        return orders;
    }

    public void setOrders(Set<Order> orders) {
        this.orders = orders;
    }

    public void addAuthor(Author author) {
        if (authors == null) {
            authors = new HashSet<>();
        }
        authors.add(author);
        author.addBook(this);
    }

    public void removeAuthor(Author author) {
        if (authors != null && authors.remove(author)) {
            author.removeBook(this);
        }
    }

    public void addOrder(Order order) {
        if (orders == null) {
            orders = new HashSet<>();
        }
        orders.add(order);
    }

    public void removeOrder(Order order) {
        if (orders != null) {
            orders.remove(order);
        }
    }

    public String authorsToString() {
        return Optional.ofNullable(authors)
                .map(a -> a.toString().replaceAll("^\\[", "").replaceAll("]$", ""))
                .orElse("");
    }

    public String toText() {
        return ">>> tytuł: " + name +
                ", autorzy: " + authorsToString() +
                ", kategoria: " + category +
                ", wydawnictwo: " + publisher +
                ", cena: " + price;
    }

    @Override
    public String toString() {
        return name;
    }

}
