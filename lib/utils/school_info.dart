import 'package:teacher_review/models/school.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final List<School> schools = [
  School(
    name: 'Cégep de l’Abitibi-Témiscamingue',
    address: '425 Boulevard du Collège',
    location: const LatLng(48.2345, -79.0193),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtAYR9w8l2Q4t7JZyY4ekFhtyLhRcqxHBH0A&s',
    id: 'af5e51a4-4880-4d0d-9231-c479e1325f11',
  ),
  School(
    name: 'Conservatoire de musique de Val-d’Or',
    address: '88 Rue Allard',
    location: const LatLng(48.1020, -77.7828),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgGo0zoMbGMQ-oFC-SmSqrYs-Mp2tD1VaqPg&s',
    id: '2e0149ed-c1ce-4b23-b08f-e1e2ec8208a0',
  ),
  School(
    name: 'Cégep de La Pocatière',
    address: '140 Rue du Parc',
    location: const LatLng(47.3674, -70.0345),
    photoUrl:
        'https://isarta.com/images-members2/2022/335/cegeplapocatiereqc/cegeplapocatiereqc_logo_rs.png?1711543888',
    id: '8401ac42-6c66-4b5a-a4be-b96a313d1039',
  ),
  School(
    name: 'Cégep de Matane',
    address: '616 Avenue Saint-Rédempteur',
    location: const LatLng(48.8374, -67.5184),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwoDdE3B--nNRhqnR-GD8W-0CiVdautG8uGg&s',
    id: '8698cba0-941b-41ed-b8fb-ae1aa3a17710',
  ),
  School(
    name: 'Cégep de Rimouski',
    address: '60 Rue de l\'Évêché O',
    location: const LatLng(48.4495, -68.5231),
    photoUrl:
        'https://www.cegep-rimouski.qc.ca/media/assets/assets/img/3138170429-1638997048/default-800x.jpg',
    id: 'd0040596-0792-4729-ab39-d67e736b4d6c',
  ),
  School(
    name: 'Cégep de Rivière-du-Loup',
    address: '80 Rue Frontenac',
    location: const LatLng(47.8345, -69.5331),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSwjXeaSJhJeaDuyTpK_WAjDFDyC8p_r01RA&s',
    id: '5acb380a-a30c-43dd-9c61-20d12cc06a4c',
  ),
  School(
    name: 'Conservatoire de musique de Rimouski',
    address: '22 Rue Sainte-Marie',
    location: const LatLng(48.4451, -68.5250),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgGo0zoMbGMQ-oFC-SmSqrYs-Mp2tD1VaqPg&s',
    id: '8d8b0ced-5ea7-4441-95df-6769f59ea9c6',
  ),
  School(
    name:
        'Institut de technologie agroalimentaire du Québec, campus de La Pocatière',
    address: '401 Boulevard de l\'Église',
    location: const LatLng(47.3650, -70.0344),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvf_e88SORzNZ3qoCLHUllzxo4A9K9i1jRKQ&s',
    id: 'acac1482-ef66-4dfe-9d20-b136781e366d',
  ),
  School(
    name: 'Cégep de Sainte-Foy',
    address: '2410 Chemin Sainte-Foy',
    location: const LatLng(46.7809, -71.2765),
    photoUrl:
        'https://upload.wikimedia.org/wikipedia/fr/thumb/8/80/Logo_C%C3%A9gep_de_Sainte-Foy.svg/2560px-Logo_C%C3%A9gep_de_Sainte-Foy.svg.png',
    id: '8cd3ac8f-776e-4b36-86ef-dbef42441373',
  ),
  School(
    name: 'Cégep Garneau',
    address: '1660 Boulevard de l\'Entente',
    location: const LatLng(46.7917, -71.2634),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgkFT2gUtcwANgE5aDyLiDPOO2bFMyeMIt_g&s',
    id: '48dd06ae-a15b-445e-b695-e316a803d742',
  ),
  School(
    name: 'Cégep Limoilou',
    address: '1300 8e Avenue',
    location: const LatLng(46.8268, -71.2276),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQspaZkDq6BIJkJhpUtuQHkIHPQ0f0Zq2-Big&s',
    id: '0105d17f-36b9-4baa-ae1b-04c91d49be38',
  ),
  School(
    name: 'Cégep Champlain - Campus Saint-Lawrence',
    address: '790 Avenue Nérée-Tremblay',
    location: const LatLng(46.7794, -71.2787),
    photoUrl: 'https://i.ytimg.com/vi/BfWlGZmxudQ/maxresdefault.jpg',
    id: '2164430a-484b-4a1b-a738-5da6c78c4a4e',
  ),
  School(
    name: 'Campus Notre-Dame-de-Foy',
    address: '5000 Rue Clément-Lockquell',
    location: const LatLng(46.7389, -71.4517),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmRn7dEjfseKZTfRTKxWWkg-L5RBwptx8Lrw&s',
    id: 'dbedb63f-411f-4c4b-9f16-eb7aefdb16f9',
  ),
  School(
    name: 'Collège Bart (1975)',
    address: '175 Rue Rachigan',
    location: const LatLng(46.8123, -71.2145),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkh3CNh3AxhKsBAOWRoo6v9UvREJD3AkvoIw&s',
    id: '9ddfee77-d123-48f5-ae5a-13ff2e575abc',
  ),
  School(
    name: 'Collège Mérici',
    address: '755 Grande Allée O',
    location: const LatLng(46.7975, -71.2321),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGZE2mX_PgbF-glWL__UOBHYpbBCgBYeQOqQ&s',
    id: '20695df4-a050-4476-9711-2854bb17ad66',
  ),
  School(
    name: 'Collège O\'Sullivan de Québec inc.',
    address: '840 Rue Saint-Jean',
    location: const LatLng(46.8122, -71.2125),
    photoUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Coll%C3%A8ge_O%27Sullivan_logo.webp/640px-Coll%C3%A8ge_O%27Sullivan_logo.webp.png',
    id: '5441388a-7851-4b6c-bc3b-aa648a63f74b',
  ),
  School(
    name: 'Collège Avalon',
    address: '2700 Boulevard Laurier',
    location: const LatLng(46.7746, -71.2826),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzZefxtaanuwX6o0SB4SF4plh76Eh1MCNklQ&s',
    id: 'fb67a074-7b7c-4fad-b23f-44533581c018',
  ),
  School(
    name: 'Collège iFly inc.',
    address: '750 Avenue du Phare Est',
    location: const LatLng(48.8502, -67.5191),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu05o5AiZQrTltbMMAbCNp1BgQuNH3hqIogw&s',
    id: '4b4a0721-fd81-4c87-8df8-e8fb4015e765',
  ),
  School(
    name: 'L’École de danse de Québec',
    address: '310 Boulevard Langelier',
    location: const LatLng(46.8123, -71.2125),
    photoUrl:
        'https://www.quebecdanse.org/wp-content/uploads/users/297/rqd_profile/gallery_1338676317.jpg',
    id: '8860504b-cf69-4701-a6b2-6a95ce0ee7c7',
  ),
  School(
    name: 'Conservatoire de musique de Québec',
    address: '270 Rue Jacques-Parizeau',
    location: const LatLng(46.8075, -71.2140),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWLCvH5CNU6ZEMjMLDiZbaFWPqq9ViJWOXTw&s',
    id: 'fea4c407-acc1-4b88-867e-59ead2891f0c',
  ),
  School(
    name: 'Cégep de Drummondville',
    address: '960 Rue Saint-Georges',
    location: const LatLng(45.8787, -72.4938),
    photoUrl:
        'https://www.cegepdrummond.ca/wp-content/themes/cegep2017/img/simple_logo.svg',
    id: '2868d7d3-320f-4857-b89e-e333576eee36',
  ),
  School(
    name: 'Cégep de Victoriaville',
    address: '475 Rue Notre-Dame E',
    location: const LatLng(46.0566, -71.9587),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvNl_CxJGBmrJRPZiKtMyqFiGQ_ziOT8ob4w&s',
    id: '4f7cda9f-33c6-435a-a4ec-1cc493da2b5e',
  ),
  School(
    name: 'Collège Ellis',
    address: '220 Rue Saint-Louis',
    location: const LatLng(45.8837, -72.4838),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy8jboW6-Ko80v3gTN8OvSzsO_sFsLVq38Fg&s',
    id: '05cf48f0-a17f-479b-b621-2e91cf2a81c4',
  ),
  School(
    name: 'Cégep Beauce-Appalaches',
    address: '1055 Boulevard Dionne',
    location: const LatLng(46.1206, -70.6790),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo3MwEHwCJXKyL0i2kSgqI0Ypx9ocTQ9XNpg&s',
    id: 'cf8ac4d9-5dec-4e1b-8c2c-a621e4d0cb30',
  ),
  School(
    name: 'Cégep de Lévis',
    address: '205 Rue Monseigneur-Bourget',
    location: const LatLng(46.8033, -71.1805),
    photoUrl:
        'https://upload.wikimedia.org/wikipedia/commons/9/93/C%C3%A9gep_de_L%C3%A9vis_logo.png',
    id: '7e75de5d-769a-45bc-a86a-b0432560b232',
  ),
  School(
    name: 'Cégep de Thetford',
    address: '671 Boulevard Frontenac O',
    location: const LatLng(46.0959, -71.3054),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStBLzTUgkdnGl2QohJyib74XbXnQZ-tbihkg&s',
    id: '7b5001ff-4c95-4fa0-8d74-ef466d51a4f5',
  ),
  School(
    name: 'Cégep de Baie-Comeau',
    address: '537 Boulevard Blanche',
    location: const LatLng(49.2146, -68.1645),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR33lA7dJrnIkaIS3e-5wbgkooeyaBqKZNYMw&s',
    id: 'ad161cf6-e016-4b0a-a35d-ca33c9c5bba0',
  ),
  School(
    name: 'Cégep de Sept-Îles',
    address: '175 Rue De La Vérendrye',
    location: const LatLng(50.2101, -66.3798),
    photoUrl:
        'https://images.squarespace-cdn.com/content/v1/59e805e3a8b2b05dc4d58ee7/1512000563565-HGYOYISWIKB4XUTSN733/cegep+bon+copy.png',
    id: 'ef70943b-b9fe-462b-8776-9b71463f9023',
  ),
  School(
    name: 'Cégep de Granby',
    address: '235 Rue Saint-Jacques',
    location: const LatLng(45.4006, -72.7326),
    photoUrl:
        'https://www.corridorappalachien.ca/wp-content/uploads/2022/03/cegep-granby.jpg',
    id: '1bfbde81-475d-473f-acb5-9014543a9b8f',
  ),
  School(
    name: 'Cégep de Sherbrooke',
    address: '475 Rue du Cégep',
    location: const LatLng(45.4035, -71.8717),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtY9zbX0dVEsX_sR61vQWxsCh-JJMBXuur-w&s',
    id: 'ba54b973-b3a3-40e6-8bb8-ea1988cccbe0',
  ),
  School(
    name: 'Champlain Regional College - Lennoxville',
    address: '2580 Rue College',
    location: const LatLng(45.3656, -71.8533),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6x1XqJ66_aRxUVAyd00ABvHReZ0zD5wK1MQ&s',
    id: '4404c706-4331-42e7-a8bb-db11e339f90d',
  ),
  School(
    name: 'Cégep de Chicoutimi',
    address: '534 Boulevard de l\'Université E',
    location: const LatLng(48.4325, -71.0659),
    photoUrl:
        'https://diffusion.saguenay.ca/wp-content/uploads/2022/04/ceremonie.jpg',
    id: '0cf6b25e-61aa-425f-a210-ab910376922c',
  ),
  School(
    name: 'Cégep de Jonquière',
    address: '2505 Rue Saint-Hubert',
    location: const LatLng(48.4108, -71.2468),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBK-PPD138EuS8p6hMLtEaLYDdlfvJq23Hpw&s',
    id: '9d40a5b7-f39c-483a-b38b-2c442af1bc72',
  ),
  School(
    name: 'Conservatoire de musique de Saguenay',
    address: '202 Rue Racine E',
    location: const LatLng(48.4291, -71.0525),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWLCvH5CNU6ZEMjMLDiZbaFWPqq9ViJWOXTw&s',
    id: '98a6f7b1-e56f-481e-b6f4-5d41d3ef31f1',
  ),
  School(
    name: 'Séminaire de Chicoutimi',
    address: '491 Rue Jacques-Cartier E',
    location: const LatLng(48.4264, -71.0505),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEahYWhi6fCyswJMtYPEwKnTHwb3-PyCxEUA&s',
    id: '8d77b03b-ce2a-405d-9612-b6b02d7c814b',
  ),
  School(
    name: 'Cégep de Sorel-Tracy',
    address: '3000 Boulevard de Tracy',
    location: const LatLng(46.0525, -73.1070),
    photoUrl:
        'https://pbs.twimg.com/profile_images/1363597737288224773/Fedyj_nF_400x400.jpg',
    id: 'eb575714-20df-4c09-8e20-99c906efcfb1',
  ),
  School(
    name: 'Cégep de Trois-Rivières',
    address: '3500 Rue de Courval',
    location: const LatLng(46.3458, -72.5761),
    photoUrl:
        'https://www.cegeptr.qc.ca/wp-content/uploads/2018/02/CTR_Logo_RVB-250x175.jpg',
    id: 'b3afe74b-b8d5-4410-844f-83d60ec481da',
  ),
  School(
    name: 'Collège Laflèche',
    address: '1687 Boulevard du Carmel',
    location: const LatLng(46.3369, -72.5511),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1P3LMFlS4Skcp0MUS8RWuTADBguD2TFNOyw&s',
    id: '0b65945e-1d4b-4ca9-a27f-c6bb0d521359',
  ),
  School(
    name: 'Cégep de l’Outaouais',
    address: '333 Boulevard de la Cité-des-Jeunes',
    location: const LatLng(45.4372, -75.7080),
    photoUrl:
        'https://cegepoutaouais.qc.ca/wp-content/uploads/2020/11/003_CO_V_CMYK_C.jpg',
    id: '778cea9d-0dd4-485e-afe0-d89508befef3',
  ),
  School(
    name: 'Cégep Heritage College',
    address: '325 Boulevard de la Cité-des-Jeunes',
    location: const LatLng(45.4348, -75.7084),
    photoUrl:
        'https://consortiumquebec.ca/wp-content/uploads/2022/04/Heritage.png',
    id: '319b2939-be21-496f-8927-4d137c4e0d4c',
  ),
  School(
    name: 'Cégep de Saint-Hyacinthe',
    address: '3000 Avenue Boullé',
    location: const LatLng(45.6320, -72.9556),
    photoUrl:
        'https://performa-marketing.com/wp-content/uploads/2020/10/CegepStHyacinthe-logo-1.jpg',
    id: 'ef79b1ea-ddfc-42e1-ae59-7aad33d25173',
  ),
  School(
    name: 'Cégep de Saint-Jean-sur-Richelieu',
    address: '30 Boulevard du Séminaire N',
    location: const LatLng(45.3111, -73.2672),
    photoUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/4Logo-cegep-st-jean-cmyk-01.png/200px-4Logo-cegep-st-jean-cmyk-01.png',
    id: '0353473a-64c3-45f2-967b-751369973ae1',
  ),
  School(
    name: 'Cégep Édouard-Montpetit',
    address: '945 Chemin de Chambly',
    location: const LatLng(45.5284, -73.5117),
    photoUrl:
        'https://cdn.theorg.com/6bde13e0-60af-4a33-85c7-32b00d00351d_thumb.jpg',
    id: '43412fb8-b23e-42a7-a47b-2a353ba7307e',
  ),
  School(
    name: 'Collège de Valleyfield',
    address: '169 Rue Champlain',
    location: const LatLng(45.2515, -74.1330),
    photoUrl:
        'https://media.licdn.com/dms/image/C4D0BAQE69AJk5davdw/company-logo_200_200/0/1630555166656/cgep_de_valleyfield_logo?e=2147483647&v=beta&t=67sGvVqXM1S87IMQiPUgTUoZYo6GtJsJifkrh8cmJdE',
    id: '2f0fc7cc-7e5b-4c89-95e7-302304817a9c',
  ),
  School(
    name: 'Cégep André-Laurendeau',
    address: '1111 Rue Lapierre',
    location: const LatLng(45.4314, -73.6298),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3dcrQaWN3roXrNZfEukGf4uukTlZXIWbR2w&s',
    id: '2d2d753e-12da-4be2-9118-b46e061aba18',
  ),
  School(
    name: 'Cégep de Maisonneuve',
    address: '3800 Rue Sherbrooke E',
    location: const LatLng(45.550838, -73.554298),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlX4WZtbslgXfCvtLn1zs8G9BZ2ITi0Fm6Mg&s',
    id: 'd3005b2d-5714-46c6-9fc5-b3f4f90df1ce',
  ),
  School(
    name: 'Cégep de Rosemont',
    address: '6400 16e Avenue',
    location: const LatLng(45.5603, -73.5819),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8apHxvMYa93dRGSzfvG4-81GCBrGv9cJTVA&s',
    id: '82f6f695-d20a-4df8-8ace-2cb8077c511b',
  ),
  School(
    name: 'Cégep du Vieux Montréal',
    address: '255 Rue Ontario E',
    location: const LatLng(45.5167, -73.5673),
    photoUrl:
        'https://adaptech.org/fr/wp-content/uploads/sites/2/2018/10/Adaptech-Partner-Logos-800x800-23-SAIDE-Cegep-du-Vieux-Montreal.png',
    id: 'a1a7a3f9-0416-4267-b542-993c26d7a69d',
  ),
  School(
    name: 'Cégep Gérald-Godin',
    address: '15615 Boulevard Gouin O',
    location: const LatLng(45.4896, -73.8921),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0lvBcY0NXl0sviVfEE8pluh1h7AusQHC_0Q&s',
    id: 'f31ae134-0ee4-413c-bc68-ae64150a857f',
  ),
  School(
    name: 'Cégep John Abbott College',
    address: '21275 Rue Lakeshore',
    location: const LatLng(45.4068, -73.9453),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Qdeof91ucqhh_bxizzfajmUWGZjolxDKgw&s',
    id: 'a50d98f6-dca4-4b5d-84b8-982372818c2e',
  ),
  School(
    name: 'Cégep Marie-Victorin',
    address: '7000 Rue Marie-Victorin',
    location: const LatLng(45.6065, -73.6224),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvfNW6TUjyA_gVBlTfL-UuEF6kqEVgoaY3Jg&s',
    id: 'bbd39eeb-75f2-4ce2-af31-c93e431232cf',
  ),
  School(
    name: 'Cégep Vanier College',
    address: '821 Avenue Sainte-Croix',
    location: const LatLng(45.5168, -73.6753),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRuLEYTktgRoUrMQv3RYeomeyZY0jTeh0JPQ&s',
    id: '98210c52-681e-4e18-b22a-a21f7574e002',
  ),
  School(
    name: 'Collège Ahuntsic',
    address: '9155 Rue Saint-Hubert',
    location: const LatLng(45.5500, -73.6362),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDGOJ1oyy7JopZyrCDZZWrmYhzWIZhcOuxOQ&s',
    id: 'a1e864e5-09b3-44f3-9347-291eb143a240',
  ),
  School(
    name: 'Collège André-Grasset',
    address: '1001 Boulevard Crémazie E',
    location: const LatLng(45.5437, -73.6257),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSWSZbeEoP65NwOWJ6zTm_cZ8zX5NqnXsH1g&s',
    id: 'f6a29885-6775-4737-9bc1-3edcc22e5b5a',
  ),
  School(
    name: 'Collège de Bois-de-Boulogne',
    address: '10555 Avenue de Bois-de-Boulogne',
    location: const LatLng(45.5320, -73.6632),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGUKYHHO7bM1Y0FtYl3JUZy_hx6c4kKr2tAg&s',
    id: '7f8cda8f-9a83-4f6b-b578-726b6a52c423',
  ),
  School(
    name: 'Collège Herzing',
    address: '1616 Boulevard René-Lévesque O',
    location: const LatLng(45.4930, -73.5790),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNizQKhbcGQSq-6roBGplyCTBehjxoqljWVg&s',
    id: '15e799d4-1dbe-47d9-9382-10b30fde9d3f',
  ),
  School(
    name: 'Collège International Marie de France',
    address: '4635 Chemin Queen Mary',
    location: const LatLng(45.4936, -73.6283),
    photoUrl:
        'https://hotelleriejobs.s3.amazonaws.com/logos/company/33771/LOGO-OFFICIELCiMF2015.png',
    id: '3252eb5e-a88d-4448-a700-2ed28490e017 ',
  ),
  School(
    name: 'Collège Jean-de-Brébeuf',
    address: '3200 Chemin de la Côte-Sainte-Catherine',
    location: const LatLng(45.5088, -73.6216),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvMJfuY6PJpO2Gn5x9TxmLhhO8HOqBa1RCwg&s',
    id: '080cd188-0aec-4ce7-b6eb-ecc102161537',
  ),
  School(
    name: 'Collège LaSalle',
    address: '2000 Sainte-Catherine St W',
    location: const LatLng(45.4910, -73.5799),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqXEE7BqZNGKZs0CamOEu2YOKXq0P-wkHXvg&s',
    id: 'f9d9a57f-43af-41f6-993d-d54c002c396c',
  ),
  School(
    name: 'Collège Letendre',
    address: '1000 Boulevard de l\'Avenir',
    location: const LatLng(45.5700, -73.6965),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjLtzjQaL50A4afZZUugcwFzzaQLVte3WhKg&s',
    id: '4fdef6d1-079e-4355-9b96-a047a86f54a3',
  ),
  School(
    name: 'Collège Lionel-Groulx',
    address: '100 Rue Duquet',
    location: const LatLng(45.6365, -73.8430),
    photoUrl:
        'https://upload.wikimedia.org/wikipedia/commons/3/35/CollegeLionelGroulx.jpg',
    id: '3cea0ba2-6330-4345-af75-22f5cb5ba009',
  ),
  School(
    name: 'Collège Montmorency',
    address: '475 Boulevard de l\'Avenir',
    location: const LatLng(45.5770, -73.7044),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnOoAHgTKcB5DyVrVBU9oVAtk46xRy7r67ZQ&s',
    id: 'd4f744cd-b5c9-4893-be69-98f07460191e',
  ),
  School(
    name: 'Collège Notre-Dame-de-Foy',
    address: '5000 Rue Clément-Lockquell',
    location: const LatLng(46.7393, -71.4484),
    photoUrl:
        'https://media.licdn.com/dms/image/C4E0BAQHCRcr4NUJ4Ng/company-logo_200_200/0/1630590885441/campus_notre_dame_de_foy_logo?e=2147483647&v=beta&t=VDsvUaJe2hqv6shjG0iOsdj9pI1YIkqTL_JhHGzfa_A',
    id: 'd799e493-7fbc-4138-ba16-729f1d84cfb3',
  ),
  School(
    name: 'Dawson College',
    address: '3040 Rue Sherbrooke O',
    location: const LatLng(45.4893, -73.5846),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_dn-eQVNQWiKawbRF-VLi30j3wGX2Ci6AGg&s',
    id: 'c8bf76f3-7864-4653-b9dd-48b4124d12d2',
  ),
  School(
    name: 'École de danse contemporaine de Montréal',
    address: '4816 Rue Molson',
    location: const LatLng(45.5480, -73.5842),
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRsdOcPuD_CPK4nQeuQbus18NlE6RNBf_oQw&s',
    id: 'cc4ac795-7f3d-4bfd-a8a7-58562747268c',
  ),
  School(
    name: 'Marianopolis College',
    address: '4873 Rue Westmount',
    location: const LatLng(45.4908, -73.5966),
    photoUrl: 'https://www.crwflags.com/fotw/images/c/ca_cmari.gif',
    id: 'ffc649c2-2dbf-4036-bf6c-c1f247f9bf7b',
  ),
  School(
      name: 'Université du Québec en Abitibi-Témiscamingue',
      address: '445 Bd de l\'Université',
      location: const LatLng(48.4333, -71.0667),
      photoUrl:
          'https://yt3.googleusercontent.com/ytc/AIdro_ms-B4xAOzfXq3pFsuV5mzPWmWTdWfVXOlA9pA2zLKXVag=s900-c-k-c0x00ffffff-no-rj',
      id: 'Université du Québec en Abitibi-Témiscamingue'),
  School(
      name: 'Université du Québec à Rimouski',
      address: '300, allée des Ursulines',
      location: const LatLng(48.4382, -68.5154),
      photoUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRENkSykzBGxFGh2VagBG8mWFiA6O9HMefFJQ&s',
      id: '10914462-75fd-4ec5-b42d-a311e811613b'),
  School(
      name: 'École nationale d’administration publique',
      address: '4750 Av. Henri-Julien',
      location: const LatLng(46.7932, -71.2536),
      photoUrl: 'https://www.sencampus.com/app/uploads/enap-550x550.jpg',
      id: '4584c228-53e9-42cd-ba94-aaf29b89016e'),
  School(
      name: 'Université Laval',
      address: '2325 Rue de l\'Université',
      location: const LatLng(46.7792, -71.2758),
      photoUrl:
          'https://ih1.redbubble.net/image.5287366206.2587/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.webp',
      id: 'cc92d266-bdd0-4022-8d8d-252aebe74187'),
  School(
      name: 'Université Bishop’s',
      address: '2600 Rue College',
      location: const LatLng(45.3651, -71.8685),
      photoUrl: 'https://www.sencampus.com/app/uploads/bishops-550x550.jpg',
      id: '2685b1a1-70a3-4171-93ba-cdfdab0afa12'),
  School(
      name: 'Université de Sherbrooke',
      address: '2500 Bd de l\'Université',
      location: const LatLng(45.3782, -71.9311),
      photoUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFPPgyUO77MJbOJ6_ydJ86zAFIR3SBdL-LpQ&s',
      id: '523ef610-f478-47f3-87d8-d60a24be542a'),
  School(
      name: 'Université du Québec à Trois-Rivières',
      address: '3351, boulevard des Forges',
      location: const LatLng(46.3455, -72.5518),
      photoUrl:
          'https://oraprdnt.uqtr.uquebec.ca/catalogue/image/uqtr/v-UQTR.png',
      id: '548ab980-bfa9-4966-886e-406186e411af'),
  School(
      name: 'École des hautes études commerciales de Montréal',
      address: '3000 Chem. de la Côte-Sainte-Catherine',
      location: const LatLng(45.5044, -73.5785),
      photoUrl:
          'https://cdn.cookielaw.org/logos/03060cb1-bad1-41a3-9f11-d8c0043f846f/ab0b636a-40e9-4094-a6ac-bb962d6f2ff7/3d9dfa3b-a610-4b85-9b33-c68780903b40/Signature_carree_Imp_HEC_Montreal_RGB.png',
      id: '43131c0f-2f25-493d-9a2d-de42b21f3a99'),
  School(
      name: 'École de technologie supérieure',
      address: '1100 R. Notre Dame O',
      location: const LatLng(45.4921, -73.5626),
      photoUrl: 'https://scwist.ca/wp-content/uploads/Logo_ETS_EN-4.jpg',
      id: '78ba2fb1-a5e0-41a6-b340-2dcd3b5223ad'),
  School(
      name: 'Polytechnique Montréal',
      address: '2500 Chem. de Polytechnique',
      location: const LatLng(45.5079, -73.6156),
      photoUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgQu5sDEYjbsszAQZXcnuBXYdjnFiOmr3dww&s',
      id: '27895a29-9166-45e8-84da-3cecf947c762'),
  School(
      name: 'Université Concordia',
      address: '1455 Blvd. De Maisonneuve Ouest',
      location: const LatLng(45.497211, -73.578621),
      photoUrl:
          'https://wooriphilippines.ph/wp-content/uploads/2021/12/Concordia-University.png',
      id: 'a60610c5-5b1a-4dac-ab64-ed723f93f1fb'),
  School(
      name: 'Université de Montréal',
      address: '2900 Bd Édouard-Montpetit',
      location: const LatLng(45.503300, -73.618530),
      photoUrl:
          'https://media.printables.com/media/prints/834912/images/6433825_5fab7532-1b26-47cb-b755-77664f05ce29_619ec669-7f60-4d20-ab4b-92c2b48e2d2b/udemm.png',
      id: '26c49a0d-9f1c-482a-a600-de50071987da'),
  School(
      name: 'Université McGill',
      address: '845 Rue Sherbrooke O',
      location: const LatLng(45.505310, -73.577810),
      photoUrl:
          'https://cdn.freebiesupply.com/logos/large/2x/mcgill-university-logo-png-transparent.png',
      id: '2a665710-d472-4a12-986e-b1e334975d02'),
  School(
      name: 'Université du Québec en Outaouais',
      address: '283 Boul. Alexandre-Taché',
      location: const LatLng(45.422780, -75.739000),
      photoUrl: 'https://cybereco.ca/wp-content/uploads/uqo-site-web.png',
      id: '56dfb5e4-7172-40ac-8a54-044c70e537d5'),
  School(
      name: 'Université du Québec à Chicoutimi',
      address: '555 Bd de l\'Université',
      location: const LatLng(48.420070, -71.052530),
      photoUrl:
          'https://i0.wp.com/inrest.ca/wp-content/uploads/2020/07/Logo-UQAC.png?fit=1001%2C1001&ssl=1',
      id: 'ce9823ca-2818-4624-82b2-dc88dfd12f3d'),
];
