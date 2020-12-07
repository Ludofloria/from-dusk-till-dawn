package nl.d2n.model;

import com.google.gson.annotations.Expose;

public class InsideBuildingResourceCost {

    @Expose
    private Long itemId;

    @Expose
    private Integer amount;

    public Long getItemId() { return this.itemId; }
    public Integer getAmount() { return this.amount; }

    public void setItemId(Long itemId) { this.itemId = itemId; }
    public void setAmount(Integer amount) { this.amount = amount; }
}
