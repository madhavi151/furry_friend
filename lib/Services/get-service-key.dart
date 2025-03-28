// ignore: file_names
import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
  "type": "service_account",
  "project_id": "furry-friend-2121b",
  "private_key_id": "978e57101dcc2feafee569375c09b4da06d117ad",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDc2JQXC4/+COqV\ns5WnHuVzpCYOZNAaPqTrieeUgENP6eihj7277XfFi2TFCUE0R94+GAPtCLvhu0VI\nGyjQEkqRYrJJIdgNZZ/fHgM29Din28hEE+sWLAAWpZGQSHjbMSZRevNrv2nXh36X\nQkqnJvbrv1URmGy/es/NCAAykauvqOzG3lvtuxRTOUDVzjMj3vJvfkZRc9VgFUQ4\nj4daHVgdFboY4zpgVe8B1OaVPOzLBHx95Uz9QXfbUJBsLxk8/bDK4RVBkZCJ03VF\n8fmRxjJkiclIaH42I93po1YIT/auGCZDJVPpUfmWHkBqFtvdxoKw9qxTCzlgOHsJ\nqhkhb16BAgMBAAECggEAbCzkARPHUNpCOdjQ7Z7rKoVVpMhJzQkxVDRlDG71ScAc\nFIMpn1NWzxsT3ZXGbBrl6AlwZttX2F6YNZUkHSNQhj1PchYTU6CbOjljvrfKxqIX\nywzsopwj4PPxxLhTBp7hE5lDgdwtNobmgaXVlmG2IkzCmQ9N+U7pWZdZLWwAKlaN\ndE1eUWVCtIY/OWYeBBZ/ccn4cogLg/Q8T9/ydvIVQIEaB3HAiQxDUHPTerXqap9x\nQcty9/Xp/f/ZXts46Okl5747DkNDoVC1gxts1DiI2Ay7dQrC+u65UPndXykuu8Or\nmh57kaUYG8WXLSdHpqMpI9xcsUrtL46YCFRjmL1VDwKBgQD7WyERAOkAYtSVyHBl\nZjdDBC+KeXeX5wWXssm7BWtBoWUY2m3oRWuy3sbjNhHJjKTwiJQmMeyTqdcJ6HBR\nE2gkfrONYfGf2hBNMl/K/3KnshcctNovMnh/rQ5ouIPt7xPM7149Ia5PVglG2E2E\nClbZ2hyymYNUfkT3T5i3I7Gm2wKBgQDg7SRz11gXjaSRR+HQSoYq01B4ad7ihn8h\nWNxsdroyT2ldF37g6eyKaz2bVFf7f1YX+eu2EIZrLYQ7ht7etr50rGI0jcou3Fig\nuSZ76cENzPB2jLAb+H7Gi1CHd29SMpZRqk11EFLOtzn3SWmTjp+6lTMezEMxMVVM\nt8mqtiQI0wKBgBcH+ZaqQ69CXwI+dHYGEKg2WPjSOnATvgJxYmSdkX9Y/39wfEOd\nIMop+YVWLfkOxwo3KYP6bRf2pvqEbs4u/griBSe+QrqH65h3NinOkD3nZpC9zYQn\nlrz0KW7VAVmq32CWykbFsEgatQzlwuyHWf/qKVkAEfWLAFy80Vxui9ejAoGANJbd\nrgQMgb1JW/p9jrDN+9daejzusvIVaVuYdfewgzDUBsMGlFm9R4PZbKbkx1W3cHWr\nqe7lLsv+ndhj5Zi+oRLpBzabricwxatklxZJYAupsV4lkvSf15YdJv9C1OolAUUb\nRSKi6dgnQm00tR5ktEBMKohBsY/CTOSvzy008acCgYAOJw/2hkidpARmnt0eEl8c\nfnlUl5Ny0TCSBgT/D8op5ClEh575Axnm9EUMHN2LxjvbF3H/AjZ7cujgnvdGRhnY\nTd2E4FBVquIwOgkRFvHm+qeN3BO8it1RejtW3O8kKcbHJYY+iZ+eha8m8s48zT86\nS/vOI5GTrEByqXzQeg9CZQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-fbsvc@furry-friend-2121b.iam.gserviceaccount.com",
  "client_id": "115399413757335240557",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40furry-friend-2121b.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}