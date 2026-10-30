package com.oftenenough.app.app

import android.content.Context
import android.media.AudioAttributes
import android.media.AudioManager
import android.media.SoundPool
import com.oftenenough.app.R

/**
 * The chime of **Sound when done** (Settings, Figma 1173:547; the iPhone's `TickFeedback` and its Tick.wav): played when a
 * log meets a goal (today's, or the week's or month's), never on every tap. A sonification sound, so it mixes with music;
 * the phone's silent and vibrate modes mute it, as Figma's flow says ("Android's silent mode mutes it"). Loaded once, when
 * the app opens, so the first goal met already has it ready.
 */
class Chime(context: Context) {
    private val audio = context.getSystemService(AudioManager::class.java)
    private val pool = SoundPool.Builder().setMaxStreams(1).setAudioAttributes(
        AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_ASSISTANCE_SONIFICATION).setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION).build(),
    ).build()
    private val sound = pool.load(context, R.raw.tick, 1)

    fun play() {
        if (audio?.ringerMode == AudioManager.RINGER_MODE_NORMAL) pool.play(sound, 1f, 1f, 1, 0, 1f)
    }
}
