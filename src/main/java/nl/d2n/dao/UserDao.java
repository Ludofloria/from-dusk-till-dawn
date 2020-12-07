package nl.d2n.dao;

import nl.d2n.model.Citizen;
import nl.d2n.model.User;
import nl.d2n.model.UserKey;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.List;

@Repository
public class UserDao {

    private EntityManager entityManager;

    @PersistenceContext
    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    @Transactional
    public void save(final User user) {
        entityManager.merge(user);
    }

    public Long getCityId(final UserKey key) {
        List<Long> results = entityManager
                .createQuery("select u.city.id from User u where u.key = :key", Long.class)
                .setParameter("key", key)
                .getResultList();
        return (results.size() == 0 ? null : (Long) results.get(0));
    }

    public User findByGameId(final Long gameId) {
        List<User> results = entityManager
                .createQuery("from User u where u.gameId = :game_id", User.class)
                .setParameter("game_id", gameId)
                .getResultList();
        return (results.size() == 0 ? null : (User)results.get(0));
    }

    public User find(final UserKey key) {
        List<User> results = entityManager
                .createQuery("from User u where u.key = :key", User.class)
                .setParameter("key", key)
                .getResultList();
        return (results.size() == 0 ? null : (User)results.get(0));
    }

    @SuppressWarnings({"unchecked"})
    public List<User> findUsersInCity(final Long cityId) {
        return (List<User>)entityManager
                .createQuery("from User u where u.city.id = :city_id and u.name != null")
                .setParameter("city_id", cityId)
                .getResultList();
    }

    public boolean isUserInCity(final Long userId, final Long cityId) {
        return (Long)entityManager
                .createQuery("select count(*) from User u where u.id = :user_id and u.city.id = :city_id")
                .setParameter("user_id", userId)
                .setParameter("city_id", cityId)
                .getSingleResult() == 1;
    }

    @Transactional
    public void deleteUsers() {
        entityManager
                .createQuery("delete from User")
                .executeUpdate();
    }

    public List<User> findDeadUsersInTown(final Long cityId, final List<Citizen> citizens) {
        return findUsersInTown(cityId, citizens, "from User u where u.city.id = :city_id and u.gameId not in (:ids)");
    }

    public List<User> findUsersNotYetRegisteredToSameTown(final Long cityId, final List<Citizen> citizens) {
        return findUsersInTown(cityId, citizens, "from User u where (u.city.id != :city_id or u.city.id is null) and u.gameId in (:ids)");
    }

    @SuppressWarnings({"unchecked"})
    protected List<User> findUsersInTown(final Long cityId, final List<Citizen> citizens, final String query) {
        if (citizens.size() == 0)
        {
            return new ArrayList<User>();
        }
        return (List<User>)entityManager
                .createQuery(query)
                .setParameter("city_id", cityId)
                .setParameter("ids", convertCitizensToIds(citizens))
                .getResultList();
    }
    
    @SuppressWarnings({"unchecked"})
    public List<Long> findUserIds(List<Citizen> citizens) {
        return (List<Long>)entityManager
                .createQuery("select u.id from User u where u.gameId in (:ids)")
                .setParameter("ids", convertCitizensToIds(citizens))
                .getResultList();
    }

    protected List<Long> convertCitizensToIds(List<Citizen> citizens) {
        List<Long> ids = new ArrayList<Long>();
        for (Citizen citizen : citizens) {
            ids.add(citizen.getId());
        }
        return ids;
    }

}
