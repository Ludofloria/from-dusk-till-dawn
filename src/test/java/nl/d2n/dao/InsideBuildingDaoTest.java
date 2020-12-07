package nl.d2n.dao;

import nl.d2n.SpringContextTestCase;
import nl.d2n.model.City;
import nl.d2n.model.InsideBuilding;
import nl.d2n.model.InsideBuildingStatus;
import nl.d2n.model.UniqueInsideBuilding;
import nl.d2n.util.ClassCreator;
import org.junit.Test;

import javax.annotation.Resource;
import java.util.List;

import junit.framework.Assert;
import static junit.framework.Assert.assertEquals;

public class InsideBuildingDaoTest extends SpringContextTestCase {

    @Resource
    private ClassCreator classCreator;

    @Resource
    private InsideBuildingDao insideBuildingDao;

    @Test
    public void saveInsideBuilding() {
        City city = classCreator.createCity(42L, "Bay of the Damned");
        classCreator.createInsideBuilding(city, 314L, InsideBuildingStatus.AVAILABLE);
        List<InsideBuilding> buildings = insideBuildingDao.findInsideBuildings(city.getId());
        Assert.assertEquals(1, buildings.size());
        Assert.assertEquals(InsideBuildingStatus.AVAILABLE, buildings.get(0).getStatus());
        Assert.assertEquals(314L, buildings.get(0).getBuildingId().longValue());
    }
}
