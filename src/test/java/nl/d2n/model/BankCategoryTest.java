package nl.d2n.model;

import org.junit.Test;

import static junit.framework.Assert.assertEquals;

public class BankCategoryTest {

    @Test
    public void orderByAmount() {
        BankCategory category = new BankCategory();
        category.items.add(createItem(1, "Alpha", 13));
        category.items.add(createItem(2, "Beta",   8));
        category.items.add(createItem(3, "Gamma", 15));
        category.orderByAmount();
        assertItem(category.items.get(0), 3L, "Gamma", 15);
        assertItem(category.items.get(1), 1L, "Alpha", 13);
        assertItem(category.items.get(2), 2L, "Beta",   8);
    }

    protected void assertItem(Item item, Long id, String name, int amount) {
        assertEquals(id, (Long)item.getD2nItemId());
        assertEquals(name, item.getName());
        assertEquals(amount, item.getAmount());
    }
    protected Item createItem(long id, String name, int amount) {
        Item item = new Item(id, name, null, null, false, false, false, false);
        item.setAmount(amount);
        return item;
    }
}
