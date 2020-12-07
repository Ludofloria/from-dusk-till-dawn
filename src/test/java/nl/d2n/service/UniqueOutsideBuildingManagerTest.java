package nl.d2n.service;

import nl.d2n.SpringContextTestCase;
import nl.d2n.model.OutsideBuilding;
import nl.d2n.model.UniqueOutsideBuilding;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

import static junit.framework.Assert.assertEquals;

public class UniqueOutsideBuildingManagerTest extends SpringContextTestCase {

    @Autowired
    UniqueOutsideBuildingManager manager;

    @Before
    public void saveUniqueOutsideBuildings() {
        uniqueOutsideBuildingDao.save(new UniqueOutsideBuilding(13L, "Garden Shed", "Some text 123", "http://somewiki/garden_shed"));
        uniqueOutsideBuildingDao.save(new UniqueOutsideBuilding(44L, "Citizen Home", "Some text 456", "http://somewiki/citizen_home"));
        uniqueOutsideBuildingDao.save(new UniqueOutsideBuilding(67L, "Derelict Villa", "Some text 789", "http://somewiki/derelict_villa"));
        uniqueOutsideBuildingDao.save(new UniqueOutsideBuilding(128L, "Old Police Station", "Some text abc", "http://somewiki/old_police_station"));
        uniqueOutsideBuildingDao.save(new UniqueOutsideBuilding(200L, "Cave", "Some text def", "http://somewiki/cave"));
        manager.refresh();
    }

    @Test
    public void construct() {
        assertEquals(5, manager.getMap().size());
    }

    @Test
    public void mergeWithList() {
        List<OutsideBuilding> buildings = new ArrayList<OutsideBuilding>();
        buildings.add(new OutsideBuilding(13L, "Garden Shack", "Some text 123", null)); // Change the title, keep the URL
        buildings.add(new OutsideBuilding(44L, "Citizen Castle", "Some text 456", null));
        buildings.add(new OutsideBuilding(67L, "Derelict Villa", "Some text 789", null));
        buildings.add(new OutsideBuilding(128L, "Old Police Station", "Some text abc", null));
        buildings.add(new OutsideBuilding(201L, "Construction Yard", "Some text jkl", null));
        buildings.add(new OutsideBuilding(202L, "Bicycle Shop", "Some text mno", null));
        manager.checkForExistence(buildings);
        assertEquals(7, manager.getMap().size());

        assertUniqueOutsideBuilding(manager.get(13L), 13L, "Garden Shack", "Some text 123");
        assertEquals("http://somewiki/garden_shed", manager.get(13L).getUrl());
        assertUniqueOutsideBuilding(manager.get(44L), 44L, "Citizen Castle", "Some text 456");
        assertUniqueOutsideBuilding(manager.get(67L), 67L, "Derelict Villa", "Some text 789");
        assertUniqueOutsideBuilding(manager.get(128L), 128L, "Old Police Station", "Some text abc");
        assertUniqueOutsideBuilding(manager.get(200L), 200L, "Cave", "Some text def");
        assertUniqueOutsideBuilding(manager.get(201L), 201L, "Construction Yard", "Some text jkl");
        assertUniqueOutsideBuilding(manager.get(202L), 202L, "Bicycle Shop", "Some text mno");
        assertEquals(7, uniqueOutsideBuildingDao.findUniqueOutsideBuildings().size());
    }

    @Test
    public void getNames() {
        List<String> names = manager.getNames();
        assertEquals(5, names.size());
        assertEquals("Cave", names.get(0));
        assertEquals("Citizen Home", names.get(1));
        assertEquals("Derelict Villa", names.get(2));
        assertEquals("Garden Shed", names.get(3));
        assertEquals("Old Police Station", names.get(4));
    }

    protected void assertUniqueOutsideBuilding(UniqueOutsideBuilding building, Long id, String name, String flavor) {
        assertEquals(id, building.getId());
        assertEquals(name, building.getName());
        assertEquals(flavor, building.getFlavor());
    }
}
