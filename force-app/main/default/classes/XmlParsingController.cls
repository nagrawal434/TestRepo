public class XmlParsingController{
    Map<String,string> nameEmailMap = new Map<String,String>();    
    private xmldom theXMLDom;
    public XmlParsingController(){
        String testxml =
                '<?xml version="1.0" encoding="UTF-8"?>' +
                '<feed xmlns="http://www.w3.org/2005/Atom" xmlns:batch="http://schemas.google.com/gdata/batch" xmlns:gContact="http://schemas.google.com/contact/2008" xmlns:gd="http://schemas.google.com/g/2005" xmlns:openSearch="http://a9.com/-/spec/opensearchrss/1.0/">' +
                    '<id>' + 'madhu@ibirdsservices.com' + '</id>' +
                    '<updated>' + '2016-02-16T11:22:08.946Z' + '</updated>' +
                    '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                    '<title type="text">' + 'Madhu Khatyanis Contacts' + '</title>'+
                    '<link rel="alternate" type="text/html" href="https://www.google.com/"/>' +
                    '<link rel="http://schemas.google.com/g/2005#feed" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full"/>' +
                    '<link rel="http://schemas.google.com/g/2005#post" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full"/>' +
                    '<link rel="http://schemas.google.com/g/2005#batch" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/batch"/>' +
                    '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full?max-results=25"/>' +
                    '<link rel="next" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full?max-results=25&amp;start-index=26"/>' +
                    '<author>' + '<name>' + 'Madhu Khatyani' + '</name>' + '<email>' + 'madhu@ibirdsservices.com' + '</email>' + '</author>' +
                    '<generator version="1.0" uri="http://www.google.com/m8/feeds">Contacts</generator>' +
                    '<openSearch:totalResults>122</openSearch:totalResults>' +
                    '<openSearch:startIndex>1</openSearch:startIndex>' +
                    '<openSearch:itemsPerPage>25</openSearch:itemsPerPage>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/1cfa25e09a2eb36' + '</id>' +
                        '<updated>' + '2015-08-13T05:29:22.075Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">Kuhinoor Alam</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/1cfa25e09a2eb36/_grraZNDaC4gFXXLRFC_-A"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/1cfa25e09a2eb36"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/1cfa25e09a2eb36"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/1cfa25e09a2eb36/1439443762075000"/>' + 
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="kuhinoor.alam@ibirdsservices.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/261ff298acad1a5' + '</id>' +
                        '<updated>' + '2015-03-24T05:35:51.483Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text"></title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/261ff298acad1a5/1B2M2Y8AsgTpgAmY7PhCfg"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/261ff298acad1a5"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/261ff298acad1a5/1427175351483001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="dadhich.priyanka17@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/2b015a50cea72c7' + '</id>' +
                        '<updated>' + '2015-04-08T06:42:48.513Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">Rajendra Rathore</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/2b015a50cea72c7/1B2M2Y8AsgTpgAmY7PhCfg"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/2b015a50cea72c7"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/2b015a50cea72c7/1428475368513001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="rajendra@ibirdsservices.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/36731008d8defc7' + '</id>' +
                        '<updated>' +'2015-07-17T06:03:28.136Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Rohit Sethi' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/36731008d8defc7/sjNwi5YYgCWlKYOfwd8whg"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/36731008d8defc7"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/36731008d8defc7"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/36731008d8defc7/1437113008136002"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="rohit19sethi93@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/3a694918adf4579' + '</id>' +
                        '<updated>' + '2015-06-23T06:16:19.691Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Nitin Chandwani' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/3a694918adf4579/PeIndnsZdoclb9VSSIzgdw"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/3a694918adf4579"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/3a694918adf4579"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/3a694918adf4579/1435040179691001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="nitin.chandwani@ibirdsservices.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/6277eba0ee998cd' + '</id>'+
                        '<updated>' + '2015-07-01T05:30:16.462Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'shikha sharma' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/6277eba0ee998cd/1B2M2Y8AsgTpgAmY7PhCfg"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/6277eba0ee998cd"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/6277eba0ee998cd/1435728616462001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="mailtoshikhs@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/68d45478c613fc1</id>' +
                        '<updated>2015-03-10T11:43:46.786Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">Aslam Bari</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/68d45478c613fc1/1Vnopjo1u7xM4RExGC-DuA"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/68d45478c613fc1"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/68d45478c613fc1"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/68d45478c613fc1/1425987826786001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="aslam.bari@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/899da1b8e8bda36' + '</id>' +
                        '<updated>' + '2015-07-01T05:30:16.462Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Sakib Beig' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/899da1b8e8bda36/EJfVQbQ5kU1T951LPyCIYg"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/899da1b8e8bda36"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/899da1b8e8bda36"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/899da1b8e8bda36/1435728616462001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="trainer.sakib@gmail.com" primary="true"/>'+
                    '</entry>' +
                    '<entry>' +
                        '<id>http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/99577b70ff0dd04</id>' +
                        '<updated>2015-07-01T05:30:16.462Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Suraj Kumar' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/99577b70ff0dd04/nerzi05B9VsDkFltXyb1aw"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/99577b70ff0dd04"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/99577b70ff0dd04"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/99577b70ff0dd04/1435728616462001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="suraj050@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/adfe4bb8d2727f6' + '</id>' +
                        '<updated>' + '2015-12-11T13:09:28.881Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Ali Mujeeb' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/adfe4bb8d2727f6/1B2M2Y8AsgTpgAmY7PhCfg"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/adfe4bb8d2727f6"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/adfe4bb8d2727f6/1449839368881001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="amujeeb@forcebrain.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/b5a5e1c8d124726' + '</id>' +
                        '<updated>' + '2015-07-01T05:30:16.462Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Shaikh Mufiz' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/b5a5e1c8d124726/xE_hVn2ibRm8nVnahxmQ8Q"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/b5a5e1c8d124726"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/b5a5e1c8d124726"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/b5a5e1c8d124726/1435728616462001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="kabir.mufiz49@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/e67028d8c4c81e2' + '</id>' +
                        '<updated>2015-07-17T06:03:28.136Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Arti Dhunna' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/e67028d8c4c81e2/1B2M2Y8AsgTpgAmY7PhCfg"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/e67028d8c4c81e2"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/e67028d8c4c81e2/1437113008136002"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="arti.dhunna@ibirdsservices.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/eb524198a3e9a78</id>' +
                        '<updated>2015-07-01T05:30:16.462Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Sunil Sharma' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/eb524198a3e9a78/U_o4ipWn0aKloN_IpPVP3Q"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/eb524198a3e9a78"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/eb524198a3e9a78"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/eb524198a3e9a78/1435728616462001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="sunil@ibirdsservices.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/f4a81750f92d866</id>' +  
                        '<updated>2015-08-10T11:14:56.208Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +  
                        '<title type="text"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/f4a81750f92d866/1B2M2Y8AsgTpgAmY7PhCfg"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/f4a81750f92d866"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/f4a81750f92d866/1439205296208001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="deepika@ibirdsservices.com"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/13aa45498ad81a3c' + '</id>' +
                        '<updated>' + '2015-04-08T06:42:48.513Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Naresh Yadav' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/13aa45498ad81a3c/Tnf3YLaE7x-BBF09TGd5MQ"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/13aa45498ad81a3c"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/13aa45498ad81a3c"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/13aa45498ad81a3c/1428475368513001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="naresh@ibirdsservices.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/1468ea428d5f4175</id>' +
                        '<updated>2015-08-03T06:47:18.716Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/1468ea428d5f4175/1B2M2Y8AsgTpgAmY7PhCfg"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/1468ea428d5f4175"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/1468ea428d5f4175/1438584438716001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="sadhnani.manish@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/14875de68e7b7514</id>' +
                        '<updated>2015-10-13T08:21:22.142Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' +'Neha Agrawal' + '</title>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">Neha Agrawal</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/14875de68e7b7514/7T8k40qH5zg4zZR8FaHUBA"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/14875de68e7b7514"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/14875de68e7b7514"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/14875de68e7b7514/1444724482142001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="nagrawal434@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/15a13bcf0e3e27f8' + '</id>' +
                        '<updated>2015-04-02T05:45:00.228Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'shahbaz khan' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/15a13bcf0e3e27f8/1B2M2Y8AsgTpgAmY7PhCfg"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/15a13bcf0e3e27f8"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/15a13bcf0e3e27f8/1427953500228001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="khanshahbaz371@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/16a8f8058909220d' + '</id>' +
                        '<updated>2015-07-17T06:03:28.136Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Ankita Goyal' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/16a8f8058909220d/LLZhTPrTYVickca6a7I2-Q"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/16a8f8058909220d"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/16a8f8058909220d"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/16a8f8058909220d/1437113008136002"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="Ankita.goyal@ibirdsservices.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/17c2c6c50d1dc5bf</id>' +
                        '<updated>2015-03-16T06:00:57.086Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Amber Deremiah' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/17c2c6c50d1dc5bf/1B2M2Y8AsgTpgAmY7PhCfg"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/17c2c6c50d1dc5bf"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/17c2c6c50d1dc5bf/1426485657086001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="aderemiah@forcebrain.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/18024e050e065f40' + '</id>' +
                        '<updated>' + '2016-01-05T05:31:45.108Z' +  '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text"/>'+
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/18024e050e065f40/1B2M2Y8AsgTpgAmY7PhCfg"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/18024e050e065f40"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/18024e050e065f40/1451971905108002"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="diwakar.yogesh@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/181e9dca8a20f189' + '</id>' +    
                        '<updated>' + '2015-08-06T12:27:57.942Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/181e9dca8a20f189/1B2M2Y8AsgTpgAmY7PhCfg"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/181e9dca8a20f189"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/181e9dca8a20f189/1438864077942000"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="rakesh_shekhawat2001@yahoo.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/18390c638bddddb9' + '</id>' +
                        '<updated>2015-04-08T06:42:48.513Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">' + 'Ganesh Prajapati' + '</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/18390c638bddddb9/_6g7KwkI-TGgUuwf0Wl6Rg"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/18390c638bddddb9"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/18390c638bddddb9"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/18390c638bddddb9/1428475368513001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="ganesh.ajmer@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/18962d860c80dd10' + '</id>' +
                        '<updated>2015-10-13T08:21:22.142Z</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">Abbas Ali</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/18962d860c80dd10/5Sr61c4A3Gv5hXEOgU5b3A"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/18962d860c80dd10"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/18962d860c80dd10"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/18962d860c80dd10/1444724482142001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="abbas92ali@gmail.com" primary="true"/>' +
                    '</entry>' +
                    '<entry>' +
                        '<id>' + 'http://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/base/18b34bad09c7bac4' + '</id>' +
                        '<updated>' + '2015-10-13T08:21:22.142Z' + '</updated>' +
                        '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/contact/2008#contact"/>' +
                        '<title type="text">Sakib Beig</title>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#edit-photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/18b34bad09c7bac4/EJfVQbQ5kU1T951LPyCIYg"/>' +
                        '<link rel="http://schemas.google.com/contacts/2008/rel#photo" type="image/*" href="https://www.google.com/m8/feeds/photos/media/madhu%40ibirdsservices.com/18b34bad09c7bac4"/>' +
                        '<link rel="self" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/18b34bad09c7bac4"/>' +
                        '<link rel="edit" type="application/atom+xml" href="https://www.google.com/m8/feeds/contacts/madhu%40ibirdsservices.com/full/18b34bad09c7bac4/1444724482142001"/>' +
                        '<gd:email rel="http://schemas.google.com/g/2005#other" address="trainersakib@gmail.com" primary="true"/>' +
                    '</entry>' +
                '</feed>';
        theXMLDom = new  xmldom(testxml);
        List<xmldom.Element> elementStructList = theXMLDom.getElementsByTagName('entry');
        System.debug('%%%%' +theXMLDom);
        System.debug('OOOOOO' +elementStructList);
        for(xmldom.Element element :elementStructList){
            String userName = '' ;
            String userEmail = '';
            for(xmldom.Element innrElement : element.childNodes){
                if(innrElement.nodeName.toLowerCase() == 'title'){
                    userName = innrElement.nodeValue;
                }
                if(innrElement.nodeName.toLowerCase() == 'email'){
                    userEmail =  innrElement.getAttribute('address');
                }                
            } 
            nameEmailMap.put(userEmail,userName);
                System.debug('******' + userName);
                            System.debug('GGG' +nameEmailMap);      
 
        }
     }  
}