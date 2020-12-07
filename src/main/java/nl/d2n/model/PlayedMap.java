package nl.d2n.model;

import javax.xml.bind.annotation.*;

@XmlRootElement(name = "m")
@XmlAccessorType(XmlAccessType.FIELD)
public class PlayedMap {

    @XmlAttribute
    private String name;

    @XmlAttribute
    private Integer season;

    @XmlAttribute
    private Integer score;

    @XmlAttribute(name = "d")
    private Integer day;

    @XmlAttribute
    private Long id;

    @XmlAttribute(name = "v1")
    private String version;

    @XmlValue
    private String message;

    public String getName() { return name; }
    public Integer getSeason() { return season; }
    public Integer getScore() { return score; }
    public Integer getDay() { return day; }
    public Long getId() { return id; }
    public String getVersion() { return version; }
    public String getMessage() { return message; }
}
