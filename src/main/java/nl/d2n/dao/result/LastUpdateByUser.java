package nl.d2n.dao.result;

import java.util.Date;

public class LastUpdateByUser {

    private Long id;

    private Date updated;

    public LastUpdateByUser(Long id, Date updated) {
        this.id = id;
        this.updated = updated;
    }
    public Long getId() {
        return this.id;
    }
    public Date getUpdated() {
        return this.updated;
    }
}
