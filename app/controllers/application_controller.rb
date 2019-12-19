class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
		case resource
		when User
			posts_top_path
		when Admin
			admins_contacts_path
		end
	end
	def after_sign_out_path_for(resource_or_scope)
		case resource_or_scope
		when :user
		 	root_path
		when :admin
			new_admin_session_path
		end
	end

	NATIOALITY = ['Japanese','Afghan','Albanian','Algerian','American','Andorran','Angolan','Antiguans','Argentinean','Armenian',
        				'Australian','Austrian','Azerbaijani','Bahamian','Bahraini','Bangladeshi','Barbadian','Barbudans','Batswana',
        				'Belarusian','Belgian','Belizean','Beninese','Bhutanese','Bolivian','Bosnian','Brazilian','British','Bruneian',
        				'Bulgarian','Burkinabe','Burmese','Burundian','Cambodian','Cameroonian','Canadian','Cape Verdean','Central African',
        				'Chadian','Chilean','Chinese','Colombian','Comoran','Congolese','Costa Rican','Croatian','Cuban','Cypriot',
        				'Czech','Danish','Djibouti','Dominican','Dutch','East Timorese','Ecuadorean','Egyptian','Emirian','Equatorial Guinean',
        				'Eritrean','Estonian','Ethiopian','Fijian','Filipino','Finnish','French','Gabonese','Gambian','Georgian','German',
        				'Ghanaian','Greek','Grenadian','Guatemalan','Guinea-Bissauan','Guinean','Guyanese','Haitian','Herzegovinian',
        				'Honduran','Hungarian','I-Kiribati','Icelander','Indian','Indonesian','Iranian','Iraqi','Irish','Israeli','Italian',
        				'Ivorian','Jamaican','Jordanian','Kazakhstani','Kenyan','Kittian and Nevisian','Kuwaiti','Kyrgyz','Laotian','Latvian',
        				'Lebanese','Liberian','Libyan','Liechtensteiner','Lithuanian','Luxembourger','Macedonian','Malagasy','Malawian',
        				'Malaysian','Maldivan','Malian','Maltese','Marshallese','Mauritanian','Mauritian','Mexican','Micronesian','Moldovan',
        				'Monacan','Mongolian','Moroccan','Mosotho','Motswana','Mozambican','Namibian','Nauruan','Nepalese','New Zealander',
        				'Nicaraguan','Nigerian','Nigerien','North Korean','Northern Irish','Norwegian','Omani','Pakistani','Palauan',
        				'Panamanian','Papua New Guinean','Paraguayan','Peruvian','Polish','Portuguese','Qatari','Romanian','Russian',
        				'Rwandan','Saint Lucian','Salvadoran','Samoan','San Marinese','Sao Tomean','Saudi','Scottish','Senegalese',
        				'Serbian','Seychellois','Sierra Leonean','Singaporean','Slovakian','Slovenian','Solomon Islander','Somali',
        				'South African','South Korean','Spanish','Sri Lankan','Sudanese','Surinamer','Swazi','Swedish','Swiss','Syrian',
        				'Taiwanese','Tajik','Tanzanian','Thai','Togolese','Tongan','Trinidadian/Tobagonian','Tunisian','Turkish',
        				'Tuvaluan','Ugandan','Ukrainian','Uruguayan','Uzbekistani','Venezuelan','Vietnamese','Welsh','Yemenite','Zambian',
        				'Zimbabwean','other']
	COUNTRY = ['Japan','Afghanistan','Albania','Algeria','American Samoa','Andorra','Angola','Anguilla','Antarctica','Antigua and Barbuda',
							'Argentina','Armenia','Aruba','Australia','Austria','Azerbaijan','Bahamas','Bahrain','Bangladesh','Barbados','Belarus',
							'Belgium','Belize','Benin','Bermuda','Bhutan','Bolivia','Bosnia and Herzegowina','Botswana','Bouvet Island','Brazil',
							'British Indian Ocean Territory','Brunei Darussalam','Bulgaria','Burkina Faso','Burundi','Cambodia','Cameroon','Canada',
							'Cape Verde','Cayman Islands','Central African Republic','Chad','Chile','China','Christmas Island','Cocos (Keeling) Islands',
							'Colombia','Comoros','Congo','Congo, the Democratic Republic of the','Cook Islands','Costa Rica','Cote d\'Ivoire',
							'Croatia (Hrvatska)','Cuba','Cyprus','Czech Republic','Denmark','Djibouti','Dominica','Dominican Republic','East Timor',
							'Ecuador','Egypt','El Salvador','Equatorial Guinea','Eritrea','Estonia','Ethiopia','Falkland Islands (Malvinas)','Faroe Islands',
							'Fiji','Finland','France','France Metropolitan','French Guiana','French Polynesia','French Southern Territories','Gabon',
							'Gambia','Georgia','Germany','Ghana','Gibraltar','Greece','Greenland','Grenada','Guadeloupe','Guam','Guatemala','Guinea',
							'Guinea-Bissau','Guyana','Haiti','Heard and Mc Donald Islands','Holy See (Vatican City State)','Honduras','Hong Kong',
							'Hungary','Iceland','India','Indonesia','Iran (Islamic Republic of)','Iraq','Ireland','Israel','Italy','Jamaica','Jordan',
							'Kazakhstan','Kenya','Kiribati','Korea, Democratic People\'s Republic of','Korea, Republic of','Kuwait','Kyrgyzstan',
							'Lao, People\'s Democratic Republic','Latvia','Lebanon','Lesotho','Liberia','Libyan Arab Jamahiriya','Liechtenstein',
							'Lithuania','Luxembourg','Macau','Macedonia, The Former Yugoslav Republic of','Madagascar','Malawi','Malaysia',
							'Maldives','Mali','Malta','Marshall Islands','Martinique','Mauritania','Mauritius','Mayotte','Mexico','Micronesia, Federated States of',
							'Moldova, Republic of','Monaco','Mongolia','Montserrat','Morocco','Mozambique','Myanmar','Namibia','Nauru','Nepal',
							'Netherlands','Netherlands Antilles','New Caledonia','New Zealand','Nicaragua','Niger','Nigeria','Niue','Norfolk Island',
							'Northern Mariana Islands','Norway','Oman','Pakistan','Palau','Panama','Papua New Guinea','Paraguay','Peru','Philippines',
							'Pitcairn','Poland','Portugal','Puerto Rico','Qatar','Reunion','Romania','Russian Federation','Rwanda','Saint Kitts and Nevis',
							'Saint Lucia','Saint Vincent and the Grenadines','Samoa','San Marino','Sao Tome and Principe','Saudi Arabia','Senegal',
							'Seychelles','Sierra Leone','Singapore','Slovakia (Slovak Republic)','Slovenia','Solomon Islands','Somalia','South Africa',
							'South Georgia and the South Sandwich Islands','Spain','Sri Lanka','St. Helena','St. Pierre and Miquelon','Sudan','Suriname',
							'Svalbard and Jan Mayen Islands','Swaziland','Sweden','Switzerland','Syrian Arab Republic','Taiwan, Province of China','Tajikistan',
							'Tanzania, United Republic of','Thailand','Togo','Tokelau','Tonga','Trinidad and Tobago','Tunisia','Turkey','Turkmenistan',
							'Turks and Caicos Islands','Tuvalu','Uganda','Ukraine','United Arab Emirates','United Kingdom','United States',
							'United States Minor Outlying Islands','Uruguay','Uzbekistan','Vanuatu','Venezuela','Vietnam','Virgin Islands (British)',
							'Virgin Islands (U.S.)','Wallis and Futuna Islands','Western Sahara','Yemen','Yugoslavia','Zambia','Zimbabwe','other']
	LANGUAGE =  ['N/A','Japanese','Abkhazian','Afar','Afrikaans','Akan','Albanian','Amharic','Arabic','Aragonese','Armenian','Assamese',
							'Avaric','Avestan','Aymara','Azerbaijani','Bambara','Bashkir','Basque','Belarusian','Bengali','Bihari languages','Bislama',
							'Bosnian','Breton','Bulgarian','Burmese','Catalan, Valencian','Central Khmer','Chamorro','Chechen','Chichewa, Chewa, Nyanja',
							'Chinese','Church Slavonic, Old Bulgarian, Old Church Slavonic','Chuvash','Cornish','Corsican','Cree','Croatian','Czech',
							'Danish','Divehi, Dhivehi, Maldivian','Dutch, Flemish','Dzongkha','English','Esperanto','Estonian','Ewe','Faroese',
							'Fijian','Finnish','French','Fulah','Gaelic, Scottish Gaelic','Galician','Ganda','Georgian','German','Gikuyu, Kikuyu',
							'Greek (Modern)','Greenlandic, Kalaallisut','Guarani','Gujarati','Haitian, Haitian Creole','Hausa','Hebrew','Herero',
							'Hindi','Hiri Motu','Hungarian','Icelandic','Ido','Igbo','Indonesian','Interlinguan','Interlingue','Inuktitut','Inupiaq',
							'Irish','Italian','Javanese','Kannada','Kanuri','Kashmiri','Kazakh','Kinyarwanda','Komi','Kongo','Korean','Kwanyama, Kuanyama',
							'Kurdish','Kyrgyz','Lao','Latin','Latvian','Letzeburgesch, Luxembourgish','Limburgish, Limburgan, Limburger','Lingala',
							'Lithuanian','Luba-Katanga','Macedonian','Malagasy','Malay','Malayalam','Maltese','Manx','Maori','Marathi','Marshallese',
							'Moldovan, Moldavian, Romanian','Mongolian','Nauru','Navajo, Navaho','Northern Ndebele','Ndonga','Nepali','Northern Sami',
							'Norwegian','Norwegian Bokmål','Norwegian Nynorsk','Nuosu, Sichuan Yi','Occitan (post 1500)','Ojibwa','Oriya','Oromo',
							'Ossetian, Ossetic','Pali','Panjabi, Punjabi','Pashto, Pushto','Persian','Polish','Portuguese','Quechua','Romansh',
							'Rundi','Russian','Samoan','Sango','Sanskrit','Sardinian','Serbian','Shona','Sindhi','Sinhala, Sinhalese','Slovak',
							'Slovenian','Somali','Sotho, Southern','South Ndebele','Spanish, Castilian','Sundanese','Swahili','Swati','Swedish',
							'Tagalog','Tahitian','Tajik','Tamil','Tatar','Telugu','Thai','Tibetan','Tigrinya','Tonga (Tonga Islands)','Tsonga','Tswana',
							'Turkish','Turkmen','Twi','Uighur, Uyghur','Ukrainian','Urdu','Uzbek','Venda','Vietnamese','Volap_k','Walloon','Welsh',
							'Western Frisian','Wolof','Xhosa','Yiddish','Yoruba','Zhuang, Chuang','Zulu']
	AREA =  ["N/A","Kanto(Tokyo area)/関東","Kansai(Osaka area)/関西","Hokkaido/北海道","Tohoku/東北","Chubu/中部","Chugoku/中国","Shikoku/四国","Kyushu/九州","Okinawa/沖縄"]
	SEASON = ["N/A","spring","summer","automn","winter"]
	INTEREST = ["N/A","food","shopping","entrainment","anime","music","history","religion","tradition","festival","nature","sport","outdoor"]

	protected
	def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:type_user, :name_first, :name_last, :name_user, :gender, :birthday, :nationality, :country, :language_first, :language_second, :language_third, :hobby, :introduction, :picture_profile, :picture_background])
    end
end
