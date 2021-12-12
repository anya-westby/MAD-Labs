package com.example.focusstudytimer

import android.os.Bundle
import android.os.CountDownTimer
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.navigateUp
import androidx.navigation.ui.setupActionBarWithNavController
import android.view.Menu
import android.view.MenuItem
import com.example.focusstudytimer.databinding.ActivityMainBinding
import com.example.focusstudytimer.databinding.ContentMainBinding
import com.example.focusstudytimer.util.PrefUtil

class MainActivity : AppCompatActivity() {

    //added
    enum class TimerState{
        Stopped, Paused, Running
    }

    private lateinit var appBarConfiguration: AppBarConfiguration
    private lateinit var binding: ActivityMainBinding
    private lateinit var binding2: ContentMainBinding

    //added
    private lateinit var timer: CountDownTimer
    private var timerLengthSeconds: Long = 0
    private var timerState = TimerState.Stopped
    private var secondsRemaining = 0L

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        setSupportActionBar(binding.toolbar)

        binding2 = ContentMainBinding.inflate(layoutInflater)

        //added
        actionBar?.setIcon(R.drawable.ic_timer)
        actionBar?.title = "    Timer"

        val navController = findNavController(R.id.nav_host_fragment_content_main)
        appBarConfiguration = AppBarConfiguration(navController.graph)
        setupActionBarWithNavController(navController, appBarConfiguration)

        //added
        binding.fabPlay.setOnClickListener {
            startTimer()
            timerState = TimerState.Running
            updateButtons()
        }

        binding.fabPause.setOnClickListener {
            timer.cancel()
            timerState = TimerState.Paused
            updateButtons()
        }

        binding.fabStop.setOnClickListener {
            timer.cancel()
            onTimerFinished()
        }
    }

    override fun onResume(){
        super.onResume()
        initTimer()
    }

    override fun onPause(){
        super.onPause()
        if (timerState == TimerState.Running){
            timer.cancel()
        }
        else if (timerState == TimerState.Paused){
            PrefUtil.setPreviousTimerLengthSeconds(timerLengthSeconds, this)
            PrefUtil.setSecondsRemaining(secondsRemaining, this)
            PrefUtil.setTimerState(timerState, this)
        }
    }

    private fun initTimer(){
        timerState = PrefUtil.getTimerState(this)

        if (timerState == TimerState.Stopped)
            setNewTimerLength()

        else
            setPreviousTimerLength()

        secondsRemaining = if (timerState == TimerState.Running || timerState == TimerState.Paused)
            PrefUtil.getSecondsRemaining(this)
        else
            timerLengthSeconds

        if (secondsRemaining <= 0)
            onTimerFinished()

        else if (timerState == TimerState.Running)
            startTimer()

        updateButtons()
        updateCountdownUI()
    }

    private fun onTimerFinished(){
        timerState = TimerState.Stopped
        setNewTimerLength()
        binding2.progressCountdown.progress = 0

        PrefUtil.setSecondsRemaining(timerLengthSeconds, this)
        secondsRemaining = timerLengthSeconds

        updateButtons()
        updateCountdownUI()
    }

    private fun startTimer(){
        timerState = TimerState.Running
        timer = object : CountDownTimer(secondsRemaining * 1000, 1000){
            override fun onFinish() = onTimerFinished()
            override fun onTick(millisUntilFinished: Long){
                secondsRemaining = millisUntilFinished/1000
                updateCountdownUI()
            }
        }.start()
    }

    private fun setNewTimerLength(){
        val lengthInMinutes = PrefUtil.getTimerLength(this)
        timerLengthSeconds = (lengthInMinutes * 60L)
        binding2.progressCountdown.max = timerLengthSeconds.toInt()
    }

    private fun setPreviousTimerLength(){
        timerLengthSeconds = PrefUtil.getPreviousTimerLengthSeconds(this)
        binding2.progressCountdown.max = timerLengthSeconds.toInt()
    }

    private fun updateCountdownUI(){
        val minutesUntilFinished = secondsRemaining / 60
        val secondsInMinuteUntilFinished = secondsRemaining - minutesUntilFinished * 60
        val secondsStr = secondsInMinuteUntilFinished.toString()
        if (secondsStr.length == 2)
            binding2.textViewCountdown.text = getString(R.string.equals_2)
        else
            binding2.textViewCountdown.text = "$minutesUntilFinished:0$secondsStr\="
        binding2.progressCountdown.progress = (timerLengthSeconds - secondsRemaining).toInt()
    }

    private fun updateButtons(){
        when (timerState){
            TimerState.Running ->{
                binding.fabPlay.isEnabled = false
                binding.fabPause.isEnabled = true
                binding.fabStop.isEnabled = true
            }
            TimerState.Stopped ->{
                binding.fabPlay.isEnabled = true
                binding.fabPause.isEnabled = false
                binding.fabStop.isEnabled = false
            }
            TimerState.Paused ->{
                binding.fabPlay.isEnabled = true
                binding.fabPause.isEnabled = false
                binding.fabStop.isEnabled = true
            }
        }
    }


    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        return when (item.itemId) {
            R.id.action_settings -> true
            else -> super.onOptionsItemSelected(item)
        }
    }

    override fun onSupportNavigateUp(): Boolean {
        val navController = findNavController(R.id.nav_host_fragment_content_main)
        return navController.navigateUp(appBarConfiguration)
                || super.onSupportNavigateUp()
    }
}