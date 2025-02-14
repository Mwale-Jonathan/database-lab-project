PGDMP      4            	    |            library    16.4    16.4 J    @           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            A           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            B           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            C           1262    28831    library    DATABASE     �   CREATE DATABASE library WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United Kingdom.1252';
    DROP DATABASE library;
                postgres    false            �            1259    28894    Author    TABLE     h   CREATE TABLE public."Author" (
    id bigint NOT NULL,
    full_name character varying(255) NOT NULL
);
    DROP TABLE public."Author";
       public         heap    postgres    false            �            1259    28893    Author_id_seq    SEQUENCE     x   CREATE SEQUENCE public."Author_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public."Author_id_seq";
       public          postgres    false    218            D           0    0    Author_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public."Author_id_seq" OWNED BY public."Author".id;
          public          postgres    false    217            �            1259    28918    Book    TABLE     �   CREATE TABLE public."Book" (
    id bigint NOT NULL,
    isbn character varying(13) NOT NULL,
    title character varying(255) NOT NULL,
    publisher_id bigint NOT NULL,
    publication_year smallint NOT NULL
);
    DROP TABLE public."Book";
       public         heap    postgres    false            �            1259    28945 
   BookAuthor    TABLE     y   CREATE TABLE public."BookAuthor" (
    id bigint NOT NULL,
    book_id bigint NOT NULL,
    author_id bigint NOT NULL
);
     DROP TABLE public."BookAuthor";
       public         heap    postgres    false            �            1259    28944    BookAuthor_id_seq    SEQUENCE     |   CREATE SEQUENCE public."BookAuthor_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."BookAuthor_id_seq";
       public          postgres    false    228            E           0    0    BookAuthor_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."BookAuthor_id_seq" OWNED BY public."BookAuthor".id;
          public          postgres    false    227            �            1259    28887    BookCopy    TABLE     �   CREATE TABLE public."BookCopy" (
    id bigint NOT NULL,
    book_id bigint NOT NULL,
    status character varying(50) NOT NULL,
    location character varying(255) NOT NULL
);
    DROP TABLE public."BookCopy";
       public         heap    postgres    false            �            1259    28886    BookCopy_id_seq    SEQUENCE     z   CREATE SEQUENCE public."BookCopy_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."BookCopy_id_seq";
       public          postgres    false    216            F           0    0    BookCopy_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."BookCopy_id_seq" OWNED BY public."BookCopy".id;
          public          postgres    false    215            �            1259    28917    Book_id_seq    SEQUENCE     v   CREATE SEQUENCE public."Book_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Book_id_seq";
       public          postgres    false    222            G           0    0    Book_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Book_id_seq" OWNED BY public."Book".id;
          public          postgres    false    221            �            1259    28952    Fine    TABLE     �   CREATE TABLE public."Fine" (
    id bigint NOT NULL,
    loan_id bigint NOT NULL,
    student_id bigint NOT NULL,
    amount integer NOT NULL,
    paid boolean NOT NULL,
    date_paid timestamp(0) with time zone
);
    DROP TABLE public."Fine";
       public         heap    postgres    false            �            1259    28951    Fine_id_seq    SEQUENCE     v   CREATE SEQUENCE public."Fine_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Fine_id_seq";
       public          postgres    false    230            H           0    0    Fine_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Fine_id_seq" OWNED BY public."Fine".id;
          public          postgres    false    229            �            1259    28938    Loan    TABLE     �   CREATE TABLE public."Loan" (
    id bigint NOT NULL,
    book_copy_id bigint NOT NULL,
    student_id bigint NOT NULL,
    checkout_date date NOT NULL,
    due_date date NOT NULL,
    return_date date
);
    DROP TABLE public."Loan";
       public         heap    postgres    false            �            1259    28937    Loan_id_seq    SEQUENCE     v   CREATE SEQUENCE public."Loan_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Loan_id_seq";
       public          postgres    false    226            I           0    0    Loan_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Loan_id_seq" OWNED BY public."Loan".id;
          public          postgres    false    225            �            1259    28927 	   Publisher    TABLE     �   CREATE TABLE public."Publisher" (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    country character varying(255) NOT NULL
);
    DROP TABLE public."Publisher";
       public         heap    postgres    false            �            1259    28926    Publisher_id_seq    SEQUENCE     {   CREATE SEQUENCE public."Publisher_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."Publisher_id_seq";
       public          postgres    false    224            J           0    0    Publisher_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."Publisher_id_seq" OWNED BY public."Publisher".id;
          public          postgres    false    223            �            1259    28903    Student    TABLE     >  CREATE TABLE public."Student" (
    id bigint NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone integer NOT NULL,
    student_number integer NOT NULL,
    "timestamp" timestamp(0) without time zone NOT NULL
);
    DROP TABLE public."Student";
       public         heap    postgres    false            �            1259    28902    Student_id_seq    SEQUENCE     y   CREATE SEQUENCE public."Student_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Student_id_seq";
       public          postgres    false    220            K           0    0    Student_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Student_id_seq" OWNED BY public."Student".id;
          public          postgres    false    219            t           2604    28897 	   Author id    DEFAULT     j   ALTER TABLE ONLY public."Author" ALTER COLUMN id SET DEFAULT nextval('public."Author_id_seq"'::regclass);
 :   ALTER TABLE public."Author" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            v           2604    28921    Book id    DEFAULT     f   ALTER TABLE ONLY public."Book" ALTER COLUMN id SET DEFAULT nextval('public."Book_id_seq"'::regclass);
 8   ALTER TABLE public."Book" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            y           2604    28948    BookAuthor id    DEFAULT     r   ALTER TABLE ONLY public."BookAuthor" ALTER COLUMN id SET DEFAULT nextval('public."BookAuthor_id_seq"'::regclass);
 >   ALTER TABLE public."BookAuthor" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227    228            s           2604    28890    BookCopy id    DEFAULT     n   ALTER TABLE ONLY public."BookCopy" ALTER COLUMN id SET DEFAULT nextval('public."BookCopy_id_seq"'::regclass);
 <   ALTER TABLE public."BookCopy" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            z           2604    28955    Fine id    DEFAULT     f   ALTER TABLE ONLY public."Fine" ALTER COLUMN id SET DEFAULT nextval('public."Fine_id_seq"'::regclass);
 8   ALTER TABLE public."Fine" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    230    230            x           2604    28941    Loan id    DEFAULT     f   ALTER TABLE ONLY public."Loan" ALTER COLUMN id SET DEFAULT nextval('public."Loan_id_seq"'::regclass);
 8   ALTER TABLE public."Loan" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225    226            w           2604    28930    Publisher id    DEFAULT     p   ALTER TABLE ONLY public."Publisher" ALTER COLUMN id SET DEFAULT nextval('public."Publisher_id_seq"'::regclass);
 =   ALTER TABLE public."Publisher" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    224    224            u           2604    28906 
   Student id    DEFAULT     l   ALTER TABLE ONLY public."Student" ALTER COLUMN id SET DEFAULT nextval('public."Student_id_seq"'::regclass);
 ;   ALTER TABLE public."Student" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            1          0    28894    Author 
   TABLE DATA           1   COPY public."Author" (id, full_name) FROM stdin;
    public          postgres    false    218   uS       5          0    28918    Book 
   TABLE DATA           Q   COPY public."Book" (id, isbn, title, publisher_id, publication_year) FROM stdin;
    public          postgres    false    222   �U       ;          0    28945 
   BookAuthor 
   TABLE DATA           >   COPY public."BookAuthor" (id, book_id, author_id) FROM stdin;
    public          postgres    false    228   \       /          0    28887    BookCopy 
   TABLE DATA           C   COPY public."BookCopy" (id, book_id, status, location) FROM stdin;
    public          postgres    false    216   �]       =          0    28952    Fine 
   TABLE DATA           R   COPY public."Fine" (id, loan_id, student_id, amount, paid, date_paid) FROM stdin;
    public          postgres    false    230   �h       9          0    28938    Loan 
   TABLE DATA           d   COPY public."Loan" (id, book_copy_id, student_id, checkout_date, due_date, return_date) FROM stdin;
    public          postgres    false    226   �h       7          0    28927 	   Publisher 
   TABLE DATA           >   COPY public."Publisher" (id, name, city, country) FROM stdin;
    public          postgres    false    224   �h       3          0    28903    Student 
   TABLE DATA           i   COPY public."Student" (id, first_name, last_name, email, phone, student_number, "timestamp") FROM stdin;
    public          postgres    false    220   �j       L           0    0    Author_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Author_id_seq"', 52, true);
          public          postgres    false    217            M           0    0    BookAuthor_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."BookAuthor_id_seq"', 111, true);
          public          postgres    false    227            N           0    0    BookCopy_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."BookCopy_id_seq"', 159, true);
          public          postgres    false    215            O           0    0    Book_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Book_id_seq"', 52, true);
          public          postgres    false    221            P           0    0    Fine_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Fine_id_seq"', 1, false);
          public          postgres    false    229            Q           0    0    Loan_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Loan_id_seq"', 1, false);
          public          postgres    false    225            R           0    0    Publisher_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Publisher_id_seq"', 22, true);
          public          postgres    false    223            S           0    0    Student_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Student_id_seq"', 6, true);
          public          postgres    false    219            ~           2606    28899    Author Author_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Author"
    ADD CONSTRAINT "Author_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Author" DROP CONSTRAINT "Author_pkey";
       public            postgres    false    218            �           2606    28950    BookAuthor BookAuthor_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."BookAuthor"
    ADD CONSTRAINT "BookAuthor_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."BookAuthor" DROP CONSTRAINT "BookAuthor_pkey";
       public            postgres    false    228            |           2606    28892    BookCopy BookCopy_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."BookCopy"
    ADD CONSTRAINT "BookCopy_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."BookCopy" DROP CONSTRAINT "BookCopy_pkey";
       public            postgres    false    216            �           2606    28923    Book Book_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Book" DROP CONSTRAINT "Book_pkey";
       public            postgres    false    222            �           2606    28957    Fine Fine_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Fine"
    ADD CONSTRAINT "Fine_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Fine" DROP CONSTRAINT "Fine_pkey";
       public            postgres    false    230            �           2606    28943    Loan Loan_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Loan" DROP CONSTRAINT "Loan_pkey";
       public            postgres    false    226            �           2606    28934    Publisher Publisher_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Publisher"
    ADD CONSTRAINT "Publisher_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."Publisher" DROP CONSTRAINT "Publisher_pkey";
       public            postgres    false    224            �           2606    28910    Student Student_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Student" DROP CONSTRAINT "Student_pkey";
       public            postgres    false    220            �           2606    28901    Author author_full_name_unique 
   CONSTRAINT     `   ALTER TABLE ONLY public."Author"
    ADD CONSTRAINT author_full_name_unique UNIQUE (full_name);
 J   ALTER TABLE ONLY public."Author" DROP CONSTRAINT author_full_name_unique;
       public            postgres    false    218            �           2606    28925    Book book_title_unique 
   CONSTRAINT     T   ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT book_title_unique UNIQUE (title);
 B   ALTER TABLE ONLY public."Book" DROP CONSTRAINT book_title_unique;
       public            postgres    false    222            �           2606    28936    Publisher publisher_name_unique 
   CONSTRAINT     \   ALTER TABLE ONLY public."Publisher"
    ADD CONSTRAINT publisher_name_unique UNIQUE (name);
 K   ALTER TABLE ONLY public."Publisher" DROP CONSTRAINT publisher_name_unique;
       public            postgres    false    224            �           2606    28912    Student student_email_unique 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT student_email_unique UNIQUE (email);
 H   ALTER TABLE ONLY public."Student" DROP CONSTRAINT student_email_unique;
       public            postgres    false    220            �           2606    28914    Student student_phone_unique 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT student_phone_unique UNIQUE (phone);
 H   ALTER TABLE ONLY public."Student" DROP CONSTRAINT student_phone_unique;
       public            postgres    false    220            �           2606    28916 %   Student student_student_number_unique 
   CONSTRAINT     l   ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT student_student_number_unique UNIQUE (student_number);
 Q   ALTER TABLE ONLY public."Student" DROP CONSTRAINT student_student_number_unique;
       public            postgres    false    220            �           2606    28958    Book book_publisher_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT book_publisher_id_foreign FOREIGN KEY (publisher_id) REFERENCES public."Publisher"(id);
 J   ALTER TABLE ONLY public."Book" DROP CONSTRAINT book_publisher_id_foreign;
       public          postgres    false    222    4750    224            �           2606    28963 '   BookAuthor bookauthor_author_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public."BookAuthor"
    ADD CONSTRAINT bookauthor_author_id_foreign FOREIGN KEY (author_id) REFERENCES public."Author"(id);
 S   ALTER TABLE ONLY public."BookAuthor" DROP CONSTRAINT bookauthor_author_id_foreign;
       public          postgres    false    228    4734    218            �           2606    28968 %   BookAuthor bookauthor_book_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public."BookAuthor"
    ADD CONSTRAINT bookauthor_book_id_foreign FOREIGN KEY (book_id) REFERENCES public."Book"(id);
 Q   ALTER TABLE ONLY public."BookAuthor" DROP CONSTRAINT bookauthor_book_id_foreign;
       public          postgres    false    222    4746    228            �           2606    28983 !   BookCopy bookcopy_book_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public."BookCopy"
    ADD CONSTRAINT bookcopy_book_id_foreign FOREIGN KEY (book_id) REFERENCES public."Book"(id);
 M   ALTER TABLE ONLY public."BookCopy" DROP CONSTRAINT bookcopy_book_id_foreign;
       public          postgres    false    4746    222    216            �           2606    28978    Fine fine_loan_id_foreign    FK CONSTRAINT     {   ALTER TABLE ONLY public."Fine"
    ADD CONSTRAINT fine_loan_id_foreign FOREIGN KEY (loan_id) REFERENCES public."Loan"(id);
 E   ALTER TABLE ONLY public."Fine" DROP CONSTRAINT fine_loan_id_foreign;
       public          postgres    false    4754    226    230            �           2606    28988    Fine fine_student_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public."Fine"
    ADD CONSTRAINT fine_student_id_foreign FOREIGN KEY (student_id) REFERENCES public."Student"(id);
 H   ALTER TABLE ONLY public."Fine" DROP CONSTRAINT fine_student_id_foreign;
       public          postgres    false    230    220    4738            �           2606    28993    Loan loan_book_copy_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT loan_book_copy_id_foreign FOREIGN KEY (book_copy_id) REFERENCES public."BookCopy"(id);
 J   ALTER TABLE ONLY public."Loan" DROP CONSTRAINT loan_book_copy_id_foreign;
       public          postgres    false    216    226    4732            �           2606    28973    Loan loan_student_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT loan_student_id_foreign FOREIGN KEY (student_id) REFERENCES public."Student"(id);
 H   ALTER TABLE ONLY public."Loan" DROP CONSTRAINT loan_student_id_foreign;
       public          postgres    false    4738    220    226            1   =  x�MRKo�@>����~�:h�B!�¥����m�]��42����D�X����Xx���%�%���u�P�B�1<��^��{p�ްe�X>�q
/&0�\�g����}�b��~-��/-:��?��0�`!�7��Ҷ5]g��6[��
-[�Y�
�0-=�r����Ja�^M��	�b�B%S3��G�&��?Q,�����zi-U2��l{�L?ZU��sX:k���NT�	��q�b>Y0�����@�2��+湂�Fa�Ie���mLO��ѻ�T�sz�|k�����^�@Q&��&�.��;ʧ��r�bg��W�Y*��d��f8`>W\���f�ݛt����,2�ʟ�K��]qi�Va����l���[#ڔw��
���Fq9Y�/ưO��f1�J:��5Q����D�+g,f_�_��'Y����R,G�d߹@U}��,5i�%������s���*U�m��,u��V��D��1,[��t\zA��=���)���]�t`o�y�;��[���r��c��@���u�Gj��볚N���$�u:O��8��;����sO�?�/��      5   4  x�eV˒ܸ<�_���7��,y>ػa�|A��nƐDΨ���{���HS̪��L��3�s�,���_�5=�2=�.�ʴ��{Z���K��-�F�Fr.[�J��ᚉ��|	��3�ݒ�}��e�c(��F�^��L�t�3��y-1��E�2����-��<�������HAp������z4Z���J��>F���ɱC	���ٸ�Y����J��_�����`:��Oax�䴯���a�i���U�6������BYi�o�0�mk�F���\Ͻ�k���^m�^�3N+�P����K��O&1���i�����>�,��R������B7�yn��L6ߦਲ਼a&J��36�n�o%.�jP+�Z��vx�o�Ns�^R~:�<DZ���*��K�z���o�\&V����"LC7-�9.h��� ��� �������k�i�KXG6fp�N����i�>�����^e�u$}�7t<��x��i�dK�wм�K���L�����h�\��T���1'����a�k�ʱ�CHN���䭔�g�g����񘙁�r�w7�3�q���J�80IIN	�,��AIӲ�qe�u?4�������C���m��\����.WH�r���A�o�]�F1e��1�����J����V@z�#8|��+���Zq��6>�����ޅ~��qF��d儇6�V���r��,�����'��p�7R�JR���zƕ������nִ���'� ��/�>�'Iz�dEF	��C�D��]Ӓ��Ҿut巗���Z���Q�����J�y_�C�TgPG
��Gz�[�Q�:����@�ډ��ށ�N�7�{���kJ����5��?ƶ����ߑ�������P�H�%���KZ��ƽ5��l��N�Y�*�*�轶
x�� ��8L�3u��I�|8*E6�C��|;��^{}�8�#��i=� �P�c��U���3���E_�r�P$�W����R�!؊�ᥱ�����:`���`��I�U�"��@4@�WNrHl ��ll='��q
����亀44�q����?O��Ӱ�ޛ	PK�\��bNK��	�I:�o�~F��t�����*G����xs���=�p��;��HP�#��7��|�Y�\C�b���@|���c:��r�'aQK��%�� �)�"i��c~U٦9*G��ռ��A����{t�m�H�\����<��J�jҏ�e�j�}��:�{P�I�Κ��Y�ND6���.!}���~{'�j����^�.�X$R6
��H�ڬiu}� ��p�� �^V����+Y$7�[��y��&���Cܼ����[oV��nW��Kz�p�D����+�ߠ�����a�##�P8^$5�V;�V��xN�ƪ~0���61��a��\�q8�f�]��r=�����=wa���r]衈%���$$�1�����ۢTG�e�T��KwiȆ	X�eL���Y˧�V��`ݖ��ر������5A\ٟv�����\�����4�xM/m-3F�����jW<x(������ж�� I�NJ      ;   �  x�%��!CϤ�}����_�&�/#�	��P$���m�P�h��c\.�;F��/kK�3l�`l85,��u�7��u3R�c^�����Q��X�f"\1F���F�#�B�2�q����1�W�A"����LŃ��Qqr�$u�e� ����rlk/A�����hA��V����e�:�����M�-��xT���0Eٖri\����7<���h`Q�Y^#��^N��<Z���[��|�-�]F�XԊJP5��W�'�h���!��p405q���?\J	�l�`_
�;s����4����\��"���m��R�-����q����^�>�$T5�Aa8��'�O)��Py��)�`�%� d4�s4f�GA�֨}��c��_��}I��MOK��R��/>����t]_#�����_
�[�~ � �"��      /   �
  x�]X�r�8}�_0E܁�عm�̺bOR��/��X,ӤCI�(_?��"�%�2Z�F_�9M�Q�7/���.m���[z��:��5�����\x�$o�ا�ƈ���y�6���xdj��n�����=����Qh,�G��F9�?�O?�؝��~�38��i��9u8�ؒ��S{L\	�l�"�r��=��=��>��6�6���q�~Ӂy]npx/y�����7��tΏ�n�H�h�A΂���c��;.`B\ae���^��	`B�t�"o�Mzm��ؾ$&���?vB{��k�m�?��`f/�6xt��b��~�☊�r�	�2��Oq;�8=�����@R?��1�#n?ց~=��k��	�A*�m���xI=�vxM(�ȤR�7�C�"����\87�.����o~�|k�m�L
�.�,��?�á��i|*��V3)7�q6�ʺ���8>2���r�Dk|�=��<����1�׶
��NH��1S�/H\k��o������:?������L�`N�DB��Z���:�L��F�U�����C�W��a�t���2?�5ލ�_��0=$X�d���S��'_j����{g<�tꦠ��8Bps�n15FI��������Qǩ�9gS�L��÷}<�:Tjʔ�G���V�渥����F�,|	!��إsm���<�D�'��VI�(�S��ޡ(���ht�������%tX��oO}O�5�=!l��+�qh����wL7�,_i%��S�e�A���f��txާ�_w��=���y�ʼ�+�[��VdU���$��C�����o���*_�������O���l(ŴY_�( �m<��>��aĥȺ�@������WJq�;�Y҆�>�$����F6���)s"
�O���Hy�	0�Q�J����i�Ѡ��c���g�� �cF��՘���o �	�\����S�]�Ɨ	�Mp̨�%�J��{<��4^�L
������Cf�m���ci�V��mVKf�FV��x5��c���M�@�n6�^�JO<0]��)ό�.�Q��C4s�K��0��J�'�+<b�!�� ��'p8�3#�lYf�ڋ�!@gЬÿ���<V�� ���&�z8��5A1�6rV,2�#"��q��:F�3���z=��? -��N��5;�����o�,M`!��./���0��#)��i�[ЛEQfk�tu;����Y�>,�2c��D٨0Y^0_5�YT��M��)��9Rw�Z���9W
���b`�S;x��#�%�^���Xck�eN.��_%���rQR2�z\�vHuw[ԑӋS�<��j��ZQs�˼t��]�����-����gXb�V���ѡ E��s�9G�%|ouC�o���-5<sH|�$��6:���8M��2Z7*)��!����7k�%X����_Ҙ�׋rYI��+5Cm��q����9*eEm�"v�؆�ڨ���s?t���4�L>1^Cꬬ���v�4����#�?�-z0�[�	��-��O��ή���rg�.�xq�Eh�ǟ�{:[�'����K�]��g�L6�JFC�	��b2��s�j�d�A�W)IJ`���'lYς��l�r�gjf�Q���	�!$*�Eg�tͥ���*PyA�M�_J�9���^j���@A)���W�&�][*�jn�����rdQ�1*cl�6����	~��M����9`}��L
@+����}��,���'!��U.(#��0��(+�2����χ�����<��u�r��8b���o�`� ilU�ghՈZ��'�ö �v�/4f#��Ӡ)�u�3�9OV�i�dU�^rX����Ma��`	>����q��by���8C�޷�L���E֞��[A^�8���Z �w�lM����Z�P�*�Z'�Z�y�̜2�g�±,�Y2��9��'�8�?�D�&�^���v��Hu�Gk�`O ��颥|4L�$�0��1���5
q�{�����zG�P�*=���|��jal���<��λ�K�L=I,+\����p�����R�<��c�,Ɋ�p��i	�h[h�j�,=t�F���)��ZA�����>�H��a���q?�]��ih���:�]����Nšg$��+W��,W8��8�0?-��WO��cC��]��T��� 5y�0фe#��Cz�D⃻��Cw�T�:a��W���\�ߌ�,W-(Mb��.m�*{ J<W�0�D[�ԝ��<���z�֨ʛ8���� � �h��7y��+��[���D$��aG��mB}'��2I�a����I�	��0����d����P�.���Z�Ƅ���^5������x�E�D 9}'1�K̗�+�"z��jQ�F�yX�{��c��.�3w|�Z���sj�r;ϣ�`��z�;'�t��ĵ�8E��G���#�a���fAn�lh�@��q>��J�R�m�W�*�pn�yA?� �������x������O?��oE����"�FΌShs�?C��|1ͭ!�/��So���soHh���i�g�{:]���P����Ac�5�N���uq�3If�i�෻}��o-�����Cc�1v�Y���f��i��߄�!�8���k6B=��Y��<s+���E{Z��_"}7$E@��<��4�1r.8�j ��_���hEy,�f�K��`$(��>:d���?c� l�      =      x������ � �      9      x������ � �      7     x�5R�n�0<S_��.�,��}L�ݦyE4��06k	����S8_�����4$g�s{�G�[�^��ۨ�c�F�`���=�"��:V�N�z�;�C���v���E� tn賲�>�0�\�,�����d�I��h�A[$��X�x]`P=A����W����9ZO�&tR\�SϾR�z�]`��FoJ���Y��RoSw�R�
�����H����H�"�ɐoaZ�8���F����]W���� ��e� �k�tt�-�,���<�|�Y�7	��F�-W��!a�B=����EלS/pC8�KJ�x$�^f��<�:��^�s%������izX����5�~�����x��&D�#�Z�=�;��TW-Z��ȯ$<7(�<�d�Rh>dك�Cb��g���a$�'Y�6�q���<	ɑX�Z8]C0(ې\�޽�,�jz�P��;��>����6YK_�j�I�� ����R��ovp$�S�ƎQ�\�"�����F��駚N��+ͤ8�/)�] �!��*	��_J�X�      3   �   x�]�=�0@��9hd�N�31���H�t(ROO,���|���c����/p���m���ֲ�]2D�cO�L�8��t��)aH�[�y�
{͵�u5���g́��Dy�}������zs�Ƙ�.a     