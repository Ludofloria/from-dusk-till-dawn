package nl.d2n.main;

import nl.d2n.model.*;
import nl.d2n.reader.D2NXmlReader;
import nl.d2n.reader.XmlReader;
import org.w3c.dom.Document;

public class Main {
    public static void main(String[] args) throws Exception {

        Document doc = (new XmlReader()).readFromUrl("http://mh-devenv.helan.local/api/x/v2/xml?userkey=19ce38f7bd688ddebe99e6045c835e48");
        Info info = new D2NXmlReader().convertXmlDocument(doc).getInfo();

        System.out.println(info.getGameHeader().toString());

        for (Estimation estimation : info.getEstimations()) {
            System.out.println(estimation.toString());
        }

        for (TownUpgrade upgrade : info.getUpgrades()) {
            System.out.println(upgrade.toString());
        }

        System.out.println(info.getCity().toString());
        for (InsideBuilding building : info.getCity().getBuildings()) {
            System.out.println(building.toString());
        }

        for (Item item : info.getItems()) {
            System.out.println(item.toString());
        }

        for (Citizen citizen : info.getCitizens()) {
            System.out.println(citizen.toString());
        }

        for (Cadaver cadaver : info.getCadavers()) {
            System.out.println(cadaver.toString());
        }

        System.out.println("Map: "+info.getMap().getWidth()+" x "+info.getMap().getHeight());
        for (Zone zone : info.getMap().getZones()) {
            System.out.println(zone.toString());
        }
    }
}