package nl.d2n.model;

import nl.d2n.util.XmlToObjectConverter;
import org.junit.Test;

import javax.xml.bind.JAXBException;

import static junit.framework.Assert.assertEquals;

public class EstimationTest {
    @Test
    public void unmarshallXmlSnippet() throws JAXBException {
        String xml = "<e day=\"3\" max=\"75\" min=\"67\" maxed=\"1\"/>";
        Estimation estimation = (Estimation) XmlToObjectConverter.convertXmlToObject(xml, Estimation.class);
        assertEquals(3, estimation.getDay());
        assertEquals(67, estimation.getMinimum());
        assertEquals(75, estimation.getMaximum());
        assertEquals(true, estimation.isMaxed());
    }
}
