package nl.d2n.service;

import nl.d2n.SpringContextTestCase;
import nl.d2n.model.Item;
import nl.d2n.model.ItemCategory;
import nl.d2n.model.UniqueItem;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static junit.framework.Assert.assertEquals;

public class UniqueItemManagerTest extends SpringContextTestCase {

    @Autowired
    UniqueItemManager manager;

    @Before
    public void saveUniqueItems() {
        uniqueItemDao.save(new UniqueItem(13L, "Tomato", ItemCategory.FOOD, "tomato.png", false, false, false, false));
        uniqueItemDao.save(new UniqueItem(14L, "Egg", ItemCategory.FOOD, "egg.png", false, false, false, false));
        uniqueItemDao.save(new UniqueItem(15L, "Tasty steak", ItemCategory.FOOD, "steak.png", true, false, false, false));
        uniqueItemDao.save(new UniqueItem(32L, "Concrete Block", ItemCategory.DEFENSES, "concrete.png", false, false, false, false));
        manager.refresh();
    }

    @Test
    public void construct() {
        assertEquals(4, manager.getMap().size());
    }

    @Test
    public void mergeWithList() {
        List<Item> items = new ArrayList<Item>();
        items.add(new Item(13L, "Tomato", ItemCategory.FOOD, "tomato.png", false, false, false, false));
        items.add(new Item(14L, "Egg", ItemCategory.FOOD, "egg_big.png", false, false, false, false));
        items.add(new Item(32L, "Concrete Block", ItemCategory.DEFENSES, "concrete.png", true, false, false, false));
        items.add(new Item(32L, "Concrete Block", ItemCategory.DEFENSES, "concrete.png", false, false, false, false));
        items.add(new Item(33L, "Trestle", ItemCategory.DEFENSES, "trestle.png", true, false, false, false));
        manager.checkForExistence(items);
        assertEquals(5, manager.getMap().size());
        assertUniqueItem(manager.get(13L), 13L, "Tomato", ItemCategory.FOOD, "tomato.png", false);
        assertUniqueItem(manager.get(14L), 14L, "Egg", ItemCategory.FOOD, "egg_big.png", false);
        assertUniqueItem(manager.get(32L), 32L, "Concrete Block", ItemCategory.DEFENSES, "concrete.png", true);
        assertUniqueItem(manager.get(33L), 33L, "Trestle", ItemCategory.DEFENSES, "trestle.png", true);
        assertEquals(5, uniqueItemDao.findUniqueItems().size());
    }

    @Test
    public void getItems() {
        assertEquals(5, manager.getItems().size());
    }

    @Test
    public void appendMissingFields() {
        List<Item> items = new ArrayList<Item>();
        items.add(new Item(13L, null, null, null, false, false, false, false));
        Item item = items.get(0);
        assertEquals(null, item.getName());
        assertEquals(null, item.getImage());
        assertEquals(null, item.getCategory());

        items = manager.appendMissingFields(items);
        item = items.get(0);
        assertEquals("Tomato", item.getName());
        assertEquals("tomato.png", item.getImage());
        assertEquals(ItemCategory.FOOD, item.getCategory());
    }

    @Test
    public void testImageInSprite() {
        manager.get(13L).setInSprite(true);
        List<Item> items = new ArrayList<Item>();
        items.add(new Item(42L, "Flesh Tomato", ItemCategory.FOOD, "tomato.png", false, false, false, false)); // image is not in sprite here
        manager.checkForExistence(items);
        assertEquals(true, manager.get(42L).isInSprite());
    }

    @Test
    public void testPoisonedItem() {
        manager.get(13L).setPoisoned(true);
        List<Item> items = new ArrayList<Item>();
        // Change the name from "tomato" to "Flesh Tomato" to trigger an update of the unique item
        items.add(new Item(13L, "Flesh Tomato", ItemCategory.FOOD, "tomato.png", false, false, false, false)); // tomato is not poisoned here
        manager.checkForExistence(items);
        assertEquals(true, manager.get(13L).isPoisoned());
    }

    @Test
    public void testGetItemIdsByImageNames() {
        Map<String, Long> itemIdsByImage = manager.getItemIdsByImage();
        assertEquals(4, itemIdsByImage.size());
        assertEquals((Long)13L, itemIdsByImage.get("tomato.png"));
    }

    protected void assertUniqueItem(UniqueItem item, Long id, String name, ItemCategory category, String image, boolean breakable) {
        assertEquals(id, item.getId());
        assertEquals(name, item.getName());
        assertEquals(category, item.getCategory());
        assertEquals(image, item.getImage());
        assertEquals(breakable, item.isBreakable());
    }
}
