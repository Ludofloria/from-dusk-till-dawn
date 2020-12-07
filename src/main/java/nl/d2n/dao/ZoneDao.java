package nl.d2n.dao;

import nl.d2n.model.City;
import nl.d2n.model.Zone;
import nl.d2n.model.builder.ZoneBuilder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class ZoneDao {

    private EntityManager entityManager;

    @PersistenceContext
    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    @Transactional
    public void saveZone(final Zone zone) {
        entityManager.merge(zone);
    }

    public Zone findZone(final Long id) {
        List<Zone> results = entityManager
                .createQuery("from Zone z where z.id = :id", Zone.class)
                .setParameter("id", id)
                .getResultList();
        return (results.size() == 0 ? null : (Zone)results.get(0));
    }

    public Zone findZone(final Long cityId, final Integer x, final Integer y) {
        List<Zone> results = entityManager
                .createQuery("from Zone z where z.city.id = :city_id and z.x = :x_pos and z.y = :y_pos", Zone.class)
                .setParameter("city_id", cityId)
                .setParameter("x_pos", x)
                .setParameter("y_pos",   y)
                .getResultList();
        return (results.size() == 0 ? null : (Zone)results.get(0));
    }

    @SuppressWarnings({"unchecked"})
    public List<Zone> findZones(final Long cityId) {
        return (List<Zone>)entityManager
                .createQuery("from Zone z where z.city.id = :city_id", Zone.class)
                .setParameter("city_id", cityId)
                .getResultList();
    }

    @Transactional
    public void deleteItemsInZone(final Long zoneId) {
        entityManager
                .createQuery("delete from Item i where i.zone.id = :id")
                .setParameter("id", zoneId)
                .executeUpdate();
    }

    @Transactional
    public Zone findOrCreateZone(final City city, final Integer x, final Integer y) {
        Zone currentZone = findZone(city.getId(), x, y);
        if (currentZone == null) {
            currentZone = new ZoneBuilder()
                    .setX(x)
                    .setY(y)
                    .setCity(city)
                    .toZone();
        }
        return currentZone;
    }

}
