package nl.d2n.model;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class UserStore<C> {

    private Map<Long, C> storedById = new TreeMap<Long, C>();

    private Map<Long, Long> twinoidIdToId = new TreeMap<Long, Long>();
    
    public UserStore(List<User> users) {
        for (User user : users) {
            if (user.getGameId() != null) {
                twinoidIdToId.put(user.getGameId(), user.getId());
            }
        }
    }

    public C getById(Long id) {
        return storedById.get(id);
    }

    public C getByTwinoidId(Long twinoidId) {
        Long id = twinoidIdToId.get(twinoidId);
        return id == null ? null : storedById.get(id);
    }

    public void putById(Long id, C objectToStore) {
        storedById.put(id, objectToStore);
    }
}
