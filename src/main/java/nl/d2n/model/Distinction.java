package nl.d2n.model;

import com.google.gson.annotations.Expose;

import javax.persistence.*;
import javax.xml.bind.annotation.*;

@XmlRootElement(name = "r")
@XmlAccessorType(XmlAccessType.FIELD)
@SuppressWarnings({"JpaDataSourceORMInspection", "FieldCanBeLocal"})
@Entity
@Table(name = "distinctions")
public class Distinction {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", updatable = false, nullable = false)
    private Long id;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "unique_distinction_id")
    private Long uniqueDistinctionId;

    @Expose
    @XmlAttribute(name = "name")
    @Transient
    private String name;

    @Expose
    @XmlAttribute(name = "rare")
    @Transient
    private boolean rare;

    @Expose
    @XmlAttribute(name = "n")
    @Column(name = "amount")
    private int amount;

    @Expose
    @XmlAttribute(name = "img")
    @Transient
    private String image;

    @XmlElement
    @Transient
    private Title title;

    @Expose
    @Transient
    private boolean inSprite;

    public Distinction() {}
    public Distinction(Long id, String name, boolean rare, int amount, String image, boolean inSprite,
                       User user, Long uniqueDistinctionId) {
        this.id = id;
        this.name = name;
        this.rare = rare;
        this.amount = amount;
        this.image = image;
        this.inSprite = inSprite;
        this.user = user;
        this.uniqueDistinctionId = uniqueDistinctionId;
    }

    public Long getId() { return this.id; }
    public String getName() { return this.name; }
    public boolean isRare() { return this.rare; }
    public int getAmount() { return this.amount; }
    public String getImage() { return this.image; }
    public Title getTitle() { return this.title; }
    public Long getUniqueDistinctionId() { return this.uniqueDistinctionId; }

    public void setUniqueDistinctionId(Long uniqueDistinctionId) { this.uniqueDistinctionId = uniqueDistinctionId; }
    public void setUser(User user) { this.user = user; }
    public void setAmount(int amount) { this.amount = amount; }
    public void setName(String name) { this.name = name; }
    public void setInSprite(boolean inSprite) { this.inSprite = inSprite; }
    public void setRare(boolean rare) { this.rare = rare; }
    public void setImage(String image) { this.image = image; }
}
