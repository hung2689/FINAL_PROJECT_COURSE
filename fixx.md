État HTTP 500 – Erreur interne du serveur
Type Rapport d'exception

message Cannot lazily initialize collection of role 'courseitproject.model.Users.userRoleCollection' (no session)

description Le serveur a rencontré une erreur interne qui l'a empêché de satisfaire la requête.

exception

org.hibernate.LazyInitializationException: Cannot lazily initialize collection of role 'courseitproject.model.Users.userRoleCollection' (no session)
	org.hibernate.collection.spi.AbstractPersistentCollection.throwLazyInitializationException(AbstractPersistentCollection.java:658)
	org.hibernate.collection.spi.AbstractPersistentCollection.throwLazyInitializationException(AbstractPersistentCollection.java:653)
	org.hibernate.collection.spi.AbstractPersistentCollection.withTemporarySessionIfNeeded(AbstractPersistentCollection.java:237)
	org.hibernate.collection.spi.AbstractPersistentCollection.initialize(AbstractPersistentCollection.java:634)
	org.hibernate.collection.spi.AbstractPersistentCollection.read(AbstractPersistentCollection.java:148)
	org.hibernate.collection.spi.PersistentBag.iterator(PersistentBag.java:418)
	courseitproject.model.Users.getRole(Users.java:258)
	courseitproject.controller.auther.AutherServlet.postLogin(AutherServlet.java:361)
	courseitproject.controller.auther.AutherServlet.doPost(AutherServlet.java:86)
	jakarta.servlet.http.HttpServlet.service(HttpServlet.java:590)
	jakarta.servlet.http.HttpServlet.service(HttpServlet.java:658)
	org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:51)
	courseitproject.filter.CharacterEncodingFilter.doFilter(CharacterEncodingFilter.java:39)
	courseitproject.filter.BlockJsp.doFilter(BlockJsp.java:37)
	courseitproject.filter.AuthFilter.doFilter(AuthFilter.java:63)
note La trace complète de la cause mère de cette erreur est disponible dans les fichiers journaux de ce serveur.

