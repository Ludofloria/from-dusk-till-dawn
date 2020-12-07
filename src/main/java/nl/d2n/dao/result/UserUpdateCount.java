package nl.d2n.dao.result;

public class UserUpdateCount {

    private Long id;

    private Integer reads;
    private Integer writes;

    public UserUpdateCount(Long id, Integer reads, Integer writes) {
        this.id = id;
        this.reads = reads;
        this.writes = writes;
    }
    public Long getId() {
        return this.id;
    }
    public Integer getReads() {
        return this.reads;
    }
    public Integer getWrites() {
        return this.writes;
    }
}
