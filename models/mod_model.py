import tensorflow as tf
import tensorflow_hub as hub


def jpeg_decode_fn(x):
    return tf.image.decode_jpeg(x, channels=3)


def map_fn(y):
    return tf.cast(tf.map_fn(jpeg_decode_fn, tf.io.decode_base64(y),
                             dtype=tf.uint8), dtype=tf.float32)


def mod_model(model_url: str, output_dir: str):
    model = tf.keras.Sequential()
    model.add(tf.keras.layers.Input(name='image_bytes', shape=[],
                                    dtype=tf.string))
    b64_to_numpy = tf.keras.layers.Lambda(map_fn)
    model.add(b64_to_numpy)

    # model_url = 'https://tfhub.dev/google/imagenet/resnet_v2_50/classification/5'
    net = hub.KerasLayer(model_url, name='feature_vector')
    model.add(net)

    # save the model
    model.save(output_dir)


def main():
    mod_model(
        'https://tfhub.dev/google/imagenet/resnet_v2_50/classification/5',
        './resnet50_v2')


if __name__ == '__main__':
    main()
