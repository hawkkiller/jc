// Autogenerated from Pigeon (v10.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()
/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface JcApi {
  /**
   * Logs the client in with the specified app account number and name.
   *
   * [appAccountNumber] is the app account number to log in with.
   *
   * [name] is the name to log in with.
   *
   * Returns `true` if the login was started successfully, `false` otherwise.
   */
  fun login(appAccountNumber: String, name: String): Boolean
  /**
   * Initializes the engine.
   *
   * Returns `true` if the engine was initialized successfully, `false` otherwise.
   */
  fun initialize(appKey: String): Boolean

  companion object {
    /** The codec used by JcApi. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
    /** Sets up an instance of `JcApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: JcApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcApi.login", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val appAccountNumberArg = args[0] as String
            val nameArg = args[1] as String
            var wrapped: List<Any?>
            try {
              wrapped = listOf<Any?>(api.login(appAccountNumberArg, nameArg))
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcApi.initialize", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val appKeyArg = args[0] as String
            var wrapped: List<Any?>
            try {
              wrapped = listOf<Any?>(api.initialize(appKeyArg))
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface JcCallControllerApi {
  /** Enables or disables the microphone. */
  fun enableMicrophone(value: Boolean)
  /** Enables or disables the camera. */
  fun enableCamera(value: Boolean)
  /** Enables or disables the speaker. */
  fun enableSpeaker(value: Boolean)
  /** Switches the camera. */
  fun switchCamera()
  /** Terminates the call. */
  fun terminate()
  /**
   * Initiates a call to the specified user.
   *
   * [userID] is the user ID of the user to call.
   *
   * [video] is whether the call should be a video call.
   *
   * Returns `true` if the call was initiated successfully, `false` otherwise.
   *
   * The client must be logged in before calling this method.
   */
  fun call(userID: String, video: Boolean, ticket: String): Boolean

  companion object {
    /** The codec used by JcCallControllerApi. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
    /** Sets up an instance of `JcCallControllerApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: JcCallControllerApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcCallControllerApi.enableMicrophone", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val valueArg = args[0] as Boolean
            var wrapped: List<Any?>
            try {
              api.enableMicrophone(valueArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcCallControllerApi.enableCamera", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val valueArg = args[0] as Boolean
            var wrapped: List<Any?>
            try {
              api.enableCamera(valueArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcCallControllerApi.enableSpeaker", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val valueArg = args[0] as Boolean
            var wrapped: List<Any?>
            try {
              api.enableSpeaker(valueArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcCallControllerApi.switchCamera", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.switchCamera()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcCallControllerApi.terminate", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.terminate()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcCallControllerApi.call", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val userIDArg = args[0] as String
            val videoArg = args[1] as Boolean
            val ticketArg = args[2] as String
            var wrapped: List<Any?>
            try {
              wrapped = listOf<Any?>(api.call(userIDArg, videoArg, ticketArg))
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface JcConferenceControllerApi {
  /** Enables or disables the microphone. */
  fun enableMicrophone(value: Boolean)
  /** Enables or disables the camera. */
  fun enableCamera(value: Boolean)
  /** Enables or disables the speaker. */
  fun enableSpeaker(value: Boolean)
  /** Switches the camera. */
  fun switchCamera()
  /** Leaves the conference. */
  fun leave()
  /**
   * Joins the specified conference.
   *
   * [conferenceID] is the ID of the conference to join.
   *
   * [password] is the password of the conference to join.
   *
   * Returns `true` if the conference was joined successfully, `false` otherwise.
   *
   * The client must be logged in before calling this method.
   */
  fun joinConference(conferenceID: String, password: String): Boolean

  companion object {
    /** The codec used by JcConferenceControllerApi. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
    /** Sets up an instance of `JcConferenceControllerApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: JcConferenceControllerApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcConferenceControllerApi.enableMicrophone", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val valueArg = args[0] as Boolean
            var wrapped: List<Any?>
            try {
              api.enableMicrophone(valueArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcConferenceControllerApi.enableCamera", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val valueArg = args[0] as Boolean
            var wrapped: List<Any?>
            try {
              api.enableCamera(valueArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcConferenceControllerApi.enableSpeaker", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val valueArg = args[0] as Boolean
            var wrapped: List<Any?>
            try {
              api.enableSpeaker(valueArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcConferenceControllerApi.switchCamera", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.switchCamera()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcConferenceControllerApi.leave", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.leave()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.JcConferenceControllerApi.joinConference", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val conferenceIDArg = args[0] as String
            val passwordArg = args[1] as String
            var wrapped: List<Any?>
            try {
              wrapped = listOf<Any?>(api.joinConference(conferenceIDArg, passwordArg))
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
