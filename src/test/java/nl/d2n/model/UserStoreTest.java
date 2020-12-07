package nl.d2n.model;

import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static junit.framework.Assert.assertEquals;

public class UserStoreTest {

    @Test
    public void testConstructor() {
        List<User> users = new ArrayList<User>();
        users.add(createUser(1L, "Alpha", 11L));
        users.add(createUser(2L, "Gamma", 22L));
        users.add(createUser(3L, "Beta",  33L));
        UserStore<String> store = new UserStore<String>(users);
        store.putById(1L, "Hello nr 1");
        store.putById(2L, "Hello nr 2");
        store.putById(3L, "Hello nr 3");
        assertEquals("Hello nr 1", store.getById(1L));
        assertEquals("Hello nr 2", store.getById(2L));
        assertEquals("Hello nr 3", store.getById(3L));
        assertEquals("Hello nr 1", store.getByTwinoidId(11L));
        assertEquals("Hello nr 2", store.getByTwinoidId(22L));
        assertEquals("Hello nr 3", store.getByTwinoidId(33L));
        assertEquals(null, store.getByTwinoidId(44L));
    }

    public User createUser(Long id, String name, Long gameId) {
        User user = new User();
        user.setId(id);
        user.setName(name);
        user.setGameId(gameId);
        return user;
    }
}
