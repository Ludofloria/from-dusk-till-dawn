package nl.d2n.model;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class Title {

    @XmlAttribute(name = "name")
    private String name;

    private Long uniqueDistinctionId;

    public String getName() { return this.name; }
    public Long getUniqueDistinctionId() { return uniqueDistinctionId; }
    public void setUniqueDistinctionId(Long uniqueDistinctionId) { this.uniqueDistinctionId = uniqueDistinctionId; }
}
