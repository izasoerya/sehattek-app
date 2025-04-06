-- === TABLE: admin ===
CREATE TABLE public.admin (
  uid uuid NOT NULL,
  email text NOT NULL,
  name text NULL,
  CONSTRAINT admin_profile_pkey PRIMARY KEY (uid),
  CONSTRAINT admin_profile_email_key UNIQUE (email),
  CONSTRAINT admin_uid_fkey FOREIGN KEY (uid)
    REFERENCES auth.users (id) ON UPDATE CASCADE ON DELETE SET NULL
) TABLESPACE pg_default;

-- === TABLE: service_product ===
CREATE TABLE public.service_product (
  name text NOT NULL,
  description text NOT NULL,
  price text NOT NULL,
  order_datetime timestamp with time zone NULL,
  updated_at timestamp with time zone NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  uid uuid NOT NULL DEFAULT gen_random_uuid(),
  customer_name text NULL,
  CONSTRAINT service_product_pkey PRIMARY KEY (uid),
  CONSTRAINT service_product_uid_key UNIQUE (uid)
) TABLESPACE pg_default;

-- === TABLE: status_product ===
CREATE TABLE public.status_product (
  type text NOT NULL,
  detail_info text NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  uid uuid NOT NULL,
  updated_at timestamp with time zone NULL,
  CONSTRAINT status_product_pkey PRIMARY KEY (uid),
  CONSTRAINT status_product_uid_key UNIQUE (uid)
) TABLESPACE pg_default;

-- === TABLE: service_runner ===
CREATE TABLE public.service_runner (
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  uid uuid NOT NULL DEFAULT gen_random_uuid(),
  uid_service_product uuid NOT NULL,
  uid_status_product uuid NOT NULL,
  updated_at timestamp with time zone NULL,
  uid_provider uuid NULL,
  CONSTRAINT service_runner_pkey PRIMARY KEY (uid),
  CONSTRAINT service_runner_uid_key UNIQUE (uid),
  CONSTRAINT service_runner_uid_service_product_fkey FOREIGN KEY (uid_service_product)
    REFERENCES service_product (uid) ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT service_runner_uid_status_product_fkey FOREIGN KEY (uid_status_product)
    REFERENCES status_product (uid) ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT service_runner_uid_provider_fkey FOREIGN KEY (uid_provider)
    REFERENCES auth.users (id) ON UPDATE CASCADE ON DELETE SET NULL
) TABLESPACE pg_default;

-- === TABLE: users ===
CREATE TABLE public.users (
  uid uuid NOT NULL,
  name text NULL,
  email text NULL,
  CONSTRAINT users_pkey PRIMARY KEY (uid),
  CONSTRAINT users_uid_fkey FOREIGN KEY (uid)
    REFERENCES auth.users (id)
) TABLESPACE pg_default;

-- === FUNCTION + TRIGGER: on_new_user ===
DROP TRIGGER IF EXISTS on_new_user ON auth.users;

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  IF new.raw_user_meta_data ->> 'admin' = 'false' THEN
    INSERT INTO public.users (uid, email, name)
    VALUES (
      new.id,
      new.email,
      new.raw_user_meta_data ->> 'username'
    );
  ELSE
    INSERT INTO public.admin (uid, email, name)
    VALUES (
      new.id,
      new.email,
      new.raw_user_meta_data ->> 'username'
    );
  END IF;

  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_new_user
AFTER INSERT ON auth.users
FOR EACH ROW
EXECUTE PROCEDURE public.handle_new_user();
