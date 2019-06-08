package project.dto;

public class BookSearch {

    private String author, category, publisher, title;
    private Float price;

    public BookSearch() {
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = nullIfEmpty(author);
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = nullIfEmpty(category);
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = nullIfEmpty(publisher);
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = nullIfEmpty(title);
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    private String nullIfEmpty(String string) {
        return (string != null && string.isEmpty()) ? null : string;
    }

}
